## Planning to make this into a port of Lodash?
## Set it as GD__ instead of GD__ to mark that its
## internal to this addon
class_name GD__

static func noop(
		a=null,
		b=null,
		c=null,
		d=null,
		e=null,
		f=null,
		g=null,
		h=null,
		i=null,
		j=null,
		k=null,
		l=null,
		m=null,
		n=null,
		o=null,
		p=null,
	): 
			pass

"""
Collections
"""

## Creates a dictionary composed of keys generated from the results of 
## running each element of collection thru iteratee. The corresponding value 
## of each key is the number of times the key was returned by iteratee. 
## The iteratee is invoked with one argument: (value).
## This attempts to replicate lodash's count_by. 
## See https://lodash.com/docs/4.17.15#countBy
static func count_by(collection, iteratee = null):
	if not(_is_collection(collection)):
		printerr("GD__.filter received a non-collection type object")
		return null
		
	var iter_func = _from_shorthand_to_iter(iteratee, 1)
	var counters = {}
	for item in collection:
		var key = str(iter_func.call(item,null))
		if not(counters.has(key)):
			counters[key] = 0
		counters[key] += 1
	return counters

## Iterates over elements of collection, returning an array of all elements predicate returns truthy for. 
## The predicate is invoked with two arguments (value, index|key).
## This attempts to replicate lodash's filter. 
## See https://lodash.com/docs/4.17.15#filter
static func filter(collection, iteratee = null):
	if not(_is_collection(collection)):
		printerr("GD__.filter received a non-collection type object")
		return null
		
	var iter_func = _from_shorthand_to_iter(iteratee)
	var index = 0
	var new_collection = []
	for item in collection:
		if iter_func.call(item,index):
			new_collection.append(item)
		index += 1
	return new_collection
	

## Iterates over elements of collection, returning the first element predicate returns truthy for.
## The predicate is invoked with two arguments: (value, index|key).
## This attempts to replicate lodash's find. 
## See https://lodash.com/docs/4.17.15#find
static func find(collection, iteratee = null, from_index = 0):
	if not(_is_collection(collection)):
		printerr("GD__.find received a non-collection type object")
		return null
		
	var iter_func = _from_shorthand_to_iter(iteratee)
	var index = 0
	for item in collection:
		if index >= from_index and iter_func.call(item,index):
			return item
		index += 1
	return null
	
	
## Creates a dictionary composed of keys generated from the results of 
## running each element of collection thru iteratee. The order of grouped values is 
## determined by the order they occur in collection. The corresponding value 
## of each key is an array of elements responsible for generating the key. 
## The iteratee is invoked with one argument: (value).
## See https://lodash.com/docs/4.17.15#groupBy
static func group_by(collection, iteratee = null):
	if not(_is_collection(collection)):
		printerr("GD__.filter received a non-collection type object")
		return null
		
	var iter_func = _from_shorthand_to_iter(iteratee, 1)
	var counters = {}
	for item in collection:
		var key = str(iter_func.call(item,null))
		if not(counters.has(key)):
			counters[key] = []
		counters[key].append(item)
	return counters
	

static func map(collection, iteratee):
	if not(_is_collection(collection)):
		printerr("GD__.map received a non-collection type object")
		return null
		
	
	var key
	if iteratee is String:
		key = iteratee
	else:
		assert(false,"%s is not supported as an iteratee" % iteratee)
		
	var new_collection = []
	for c in collection:
		new_collection.append(c[key])
	return new_collection

## Checks if predicate returns truthy for any element of collection. 
## Iteration is stopped once predicate returns truthy. 
## The predicate is invoked with two arguments: (value, index|key).
## This attempts to replicate lodash's some. 
## See https://lodash.com/docs/4.17.15#some
static func some(collection, iteratee = null):
	if not(_is_collection(collection)):
		printerr("GD__.some received a non-collection type object")
		return null
		
	var iter_func = _from_shorthand_to_iter(iteratee)
	var index = 0
	for item in collection:
		if iter_func.call(item,index):
			return true
		index += 1
	return false
"""
Lang
"""

## Casts value as an array if it's not one.
## Returns an empty array if null.
static func cast_array(v):
	if v:
		return v if v is Array else [v]
	else:
		return []

"""
UTILS
"""
static func identity(value, _unused = null): 
	return value
	

static func matches(dict:Dictionary) -> Callable:
	return func (value, _unused = null):
		var found = true
		for key in dict:
			var prop = value.get(key)
			found = found and (prop and dict[key] == prop)
		return found
		

static func matches_property(string:String, v):
	var splits = string.split(":")
	return func (value, _unused = null):
		return _property(splits,value) == v
		
	
## Creates a function that returns the value at path of a given object.	
static func property(string:String):
	var splits = string.split(":")
	return func (value, _unused = null):
		return _property(splits, value)
	
## The underlying function that property calls. Use this if you want
## to skip the creation of a lambda
static func _property(splits:Array,value):
	var curr_prop = value
	for split in splits:
		if curr_prop is Object:
			var attempt = curr_prop.get(split)
			if attempt != null:
				curr_prop = attempt
				continue
			else:
				return null
		if curr_prop is Dictionary:
			if curr_prop.has(split):
				curr_prop = curr_prop[split]
				continue
			else:
				return null
		if curr_prop is Array and split.is_valid_int() and int(split) < curr_prop.size():
			curr_prop = curr_prop[int(split)]
			continue
		
		return null
	return curr_prop
	
	
static func _is_collection(item):
	return item is Array or item is Dictionary
	
	
## Converts a shorthand to iterable
static func _from_shorthand_to_iter(iteratee, args_count = 2):
	var iter_func
	match typeof(iteratee):
		TYPE_DICTIONARY:
			iter_func = matches(iteratee)
		TYPE_STRING:
			iter_func = property(iteratee)
		TYPE_ARRAY:
			var prop = _property(["0"],iteratee)
			var val = _property(["1"],iteratee)
			iter_func = matches_property(
				prop,
				val
			)
		TYPE_NIL:
			iter_func = GD__.identity
		TYPE_CALLABLE:
			match args_count:
				1: iter_func = func(v,_unused): return iteratee.call(v)
				2: iter_func = iteratee
				_: assert(false,"Unsupported args count")
				
		_:
			printerr("GD__.find called with unsupported signature %s. See docs for more info" % iteratee)
	return iter_func
