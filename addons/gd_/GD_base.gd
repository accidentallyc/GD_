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




"""
Reference to original functions
"""

## Original floor to use in GD_.floor
static func __floor(n): return floor(n)

"""
Internal utility function
"""

## Wrapping it in a class o we can hide the implementation from being visible
## when accessing GD_.
class Internals:
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
	

"""
INTERNAL STUFF
"""


## Weird unexplainable case in lodash
## Try running the 2:
## 
## _.map([[1, 2, 3], [4, 5, 6], [7, 8, 9]], _.take)
## _.mapValues({a:[1, 2, 3], b:[4, 5, 6], c:[7, 8, 9]},_.take)
## 		vs
## _.map([[1, 2, 3], [4, 5, 6], [7, 8, 9]], (a,b)=> _.take(a,b))
## _.mapValues({a:[1, 2, 3], b:[4, 5, 6], c:[7, 8, 9]},(a,b) => _.take(a,b))
##
## Passing down the _.take as iterattes behaves like map 
## was NOT invoked it with 2 arguments but with only 1.
## This doesnt make sense because map invokes callbacks with 2 args (val,key)
static func __iteratee_take(array, _UNUSED_):
	return GD_.take(array, null)
	
static func _is_collection(item):
	return item is Array or item is Dictionary
	
static func _is_not_null_arg(i,_i):
	return not(is_same(i, _UNDEF_))
	
static func not_implemented():  
	assert(false, "Not implemented yet. Do you need this function? If so, open an issue and I will prioritize it")


static var __INTERNAL__:Internals = Internals.new()
