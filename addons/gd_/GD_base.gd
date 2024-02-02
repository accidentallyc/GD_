# Base class  for storing functions that have the same name as globalscope types
# And other random utility functions


# Use this to differentiate betwen default null
# and actual null values. Do not use outside of this class.
class UNDEFINED: 
	static var ref:UNDEFINED
	
	func _init():
		ref = self

static var _UNDEF_ = UNDEFINED.new()
static var _EMPTY_ARRAY_ = []
static var id_ctr = 0

static var __INTERNAL__:Internal = Internal.new():
	get:
		# We gotta do this because static is null in EditorScripts 
		if __INTERNAL__ == null:
			__INTERNAL__ = Internal.new()
		return __INTERNAL__

"""
Reference to original functions
"""

## Original floor to use in GD_.floor
static func __floor(n): return floor(n)

static func disable_warnings():
	__INTERNAL__.is_warning_enabled = false

static func enable_warnings():
	__INTERNAL__.is_warning_enabled = true

static func gd_warn(str:String):
	__INTERNAL__.last_warning = str
	if __INTERNAL__.is_warning_enabled:
		printerr(str)
"""
Internal utility function
"""

## Wrapping it in a class o we can hide the implementation from being visible
## when accessing GD_.
class Internal:
	# Used for testing purposes
	var last_warning
	var is_warning_enabled = true
	var string_to_path_rx:RegEx
	
	func _init():
		string_to_path_rx = RegEx.new()
		string_to_path_rx.compile(
		 str(
			"(\\[(?<key>[\\w\\s\'\"\\.]+)?\\])",
			"|",
			"(?<key>\'?[\\w\\s\\.]+\'?)",
			"|",
			"(?<key>\"?[\\w\\s\\.]+\"?)",
			)
		)
		
		
	## This attempts to replicate the "variable arguments"
	## Assumes that the user will fill from left to right.
	## Will break on the first UNDEFINED
	func to_clean_args(
		a = UNDEFINED.ref,
		b = UNDEFINED.ref,
		c = UNDEFINED.ref,
		d = UNDEFINED.ref,
		e = UNDEFINED.ref,
		f = UNDEFINED.ref,
		g = UNDEFINED.ref,
		h = UNDEFINED.ref,
		i = UNDEFINED.ref,
		j = UNDEFINED.ref
	):
		var cleaned = []
	
		for arg in [a,b,c,d,e,f,g,h,i,j]:
			if arg is UNDEFINED: 
				break
			cleaned.append(arg)
			
		return cleaned
		
	func set_dict_deep(dict:Dictionary, paths:Array, value):
		var curr = dict
		var size = paths.size()
		for i in range(0,size):
			var path = paths[i]
			if path in curr:
				curr = curr[path]
			elif i + 1 == size:
				curr[path] = value
			else:
				curr[path] = {}
				curr = curr[path]
	
	func is_int_like(tmp):
		return (tmp is String and tmp.is_valid_int()) or (tmp is int)
		
	## Splits the string into paths
	func string_to_path(str: String):
		var path = []
		for result in string_to_path_rx.search_all(str):
			var key = result.get_string(&"key")
			var first_char = key[0] if key and key != "[]" else null
			
			match(first_char):
				'"':
					path.append(key.substr(1,key.length() - 2))
				"'":
					path.append(key.substr(1,key.length() - 2))
				null:
					path.append(&"")
				_:
					if key.is_valid_int(): 
						path.append(int(key))
					elif key.is_valid_float(): 
						path.append(float(key))
					else: 
						path.append(key)
		
		return path
					
	
	## Attempt to get an index from an array or retural the default (null)	
	func get_index(array:Array, index:int, default_value = null):
		if index >= 0 and index < array.size():
			return array[index]
		return default_value
		
	# For functions with weird and special behaviors when used as n iteratee.
	
	func get_iteratee(callable: Callable):
		# These functions have weird lodash behaviors as iteratee's
		# Visit each function for an explanation
		match callable:
			GD_.take: return iteratee_drop_second_arg(GD_.take)
			GD_.every: return iteratee_drop_second_arg(GD_.every)
		return callable
		
	## Some iteratees completely drop the second argument when used in a map
	## For example: 
	##
	## _.map([[1, 2, 3], [4, 5, 6], [7, 8, 9]], _.take)
	## _.mapValues({a:[1, 2, 3], b:[4, 5, 6], c:[7, 8, 9]},_.take)
	## 		vs
	## _.map([[1, 2, 3], [4, 5, 6], [7, 8, 9]], (a,b)=> _.take(a,b))
	## _.mapValues({a:[1, 2, 3], b:[4, 5, 6], c:[7, 8, 9]},(a,b) => _.take(a,b))
	func iteratee_drop_second_arg(callable:Callable):
		return func (arg1, _UNUSED_):
			return callable.call(arg1, null)

"""
INTERNAL STUFF
"""



	
static func _is_collection(item):
	return item is Array or item is Dictionary or GD_.is_string_like(item)
	
static func _is_not_null_arg(i,_i):
	return not(is_same(i, _UNDEF_))
	
static func not_implemented():  
	assert(false, "Not implemented yet. Do you need this function? If so, open an issue and I will prioritize it")
