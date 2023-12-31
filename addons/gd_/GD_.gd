extends "res://addons/gd_/GD_indirect.gd"

class_name GD_

class Reference:
	pass

# Use this to differentiate betwen default null
# and actual null values. Do not use outside of this class.
static var _NULL_ARG_ = Reference.new()

"""
Array
"""
static func not_implemented():  assert(false, "Not implemented")
	
## Creates an array of elements split into groups the length of size. 
## If array can't be split evenly, the final chunk will be the remaining elements.
## This attempts to replicate lodash's chunk. 
## https://lodash.com/docs/4.17.15#chunk
static func chunk(array,size=1): 
	if not(array is Array):
		printerr("GD_.chunk received a non-array type value")
		return null
	
	# Thanks to cyberreality for the quick code they offered to the 
	# community. https://www.reddit.com/r/godot/comments/e6ae27/comment/f9p3c2e/?utm_source=share&utm_medium=web2x&context=3
	var new_array = []
	var i = 0
	var j = -1
	for item in array:
		if i % size == 0:
			new_array.append([])
			j += 1;
		new_array[j].append(item)
		i += 1
	return new_array
				
## Creates an array with all falsey values removed. 
## The falsiness is determined by a basic if statement.
## The values false, null, 0, "", [], and {} are falsey.
## This attempts to replicate lodash's compact. 
## https://lodash.com/docs/4.17.15#compact
static func compact(array):
	if not(array is Array):
		printerr("GD_.compact received a non-array type value")
		return null
		
	var new_array = []
	for item in array:
		if item:
			new_array.append(item)
	return new_array
		
## Creates a new array concatenating array with any additional arrays and/or values.
## This attempts to replicate lodash's concat. 
## This func can receive up to 10 concat values. Hopefully thats enough
## This attempts to replicate lodash's concat.
## https://lodash.com/docs/4.17.15#concat
static func concat(array, a=_NULL_ARG_,b=_NULL_ARG_,c=_NULL_ARG_,d=_NULL_ARG_,e=_NULL_ARG_,f=_NULL_ARG_,g=_NULL_ARG_,h=_NULL_ARG_,i=_NULL_ARG_,j=_NULL_ARG_,k=_NULL_ARG_):
	if not(array is Array):
		printerr("GD_.concat received a non-array type value")
		return null
		
	var new_array = []
	new_array.append_array(array)
	for arg in [a,b,c,d,e,f,g,h,i,j,k]:
		# stop after first occurence of _NULL_ARG_
		if is_same(arg,_NULL_ARG_):
			break
		if arg is Array:
			new_array.append_array(arg)
		else:
			new_array.append(arg)
	return new_array
				
			
## Creates an array of array values not included in the other given arrays 
## using == for comparisons. The order and references of result values 
## are determined by the first array.
## This attempts to replicate lodash's difference.
## https://lodash.com/docs/4.17.15#difference
static func difference(array_left, array_right): 
	if not(array_left is Array and array_right is Array):
		printerr("GD_.difference received a non-array type value")
		return null
		
	var new_array = []
	new_array.append_array(array_left)
	
	for array_item_2 in array_right:
		new_array.erase(array_item_2)
		
	return new_array


## This method is like GD_.difference except that it accepts iteratee which 
## is invoked for each element of array and values to generate the criterion 
## by which they're compared using ==. The order and references of result 
## values are determined by the first array. The iteratee is 
## invoked with one argument: (value)
## This attempts to replicate lodash's differenceBy.
## https://lodash.com/docs/4.17.15#differenceBy
static func difference_by(array_left, array_right, iteratee = null): 
	if not(array_left is Array and array_right is Array):
		printerr("GD_.difference_by received a non-array type value")
		return null
		
	var iter_func = iteratee(iteratee)
	
	# new return array
	var new_array = []
	
	# store processed keyes here
	var keys_to_remove_map = {}
	for array_item_2 in array_right:
		keys_to_remove_map[iter_func.call(array_item_2)] = true
		
	var array_right_max = array_left.size()
	
	for left_item in array_left:
		var left_key = iter_func.call(left_item)
		if not(keys_to_remove_map.has(left_key)):
			new_array.append(left_item)
			
	return new_array
	
## This method is like GD_.difference except that it accepts comparator 
## which is invoked to compare elements of array to values. 
## The order and references of result values are determined by the first array. 
## The comparator is invoked with two arguments: (arrVal, othVal).
## This attempts to replicate lodash's differenceWith.
## https://lodash.com/docs/4.17.15#differenceWith
static func difference_with(array_left, array_right, comparator:Callable): 
	if not(array_left is Array and array_right is Array):
		printerr("GD_.difference_with received a non-array type value")
		return null
		
	var new_array = []
	var has_match = false
	for left_item in array_left:
		has_match = false
		for right_item in array_right:
			var res = comparator.call(left_item,right_item)
			if comparator.call(left_item,right_item):
				has_match = true
				break
		if not(has_match):
			new_array.append(left_item)
	return new_array
	

## Creates a slice of array with n elements dropped from the beginning.
## This attempts to replicate lodash's drop.
## https://lodash.com/docs/4.17.15#drop
static func drop(array, n:int=1):
	if not(array is Array):
		printerr("GD_.drop received a non-array type value")
		return null
		
	var size = array.size()
	var new_array = []
	var i = n
	while i < size:
		new_array.append(array[i])
		i += 1
		
	return new_array
	
	
## Creates a slice of array with n elements dropped from the beginning.
## This attempts to replicate lodash's dropRight.
## https://lodash.com/docs/4.17.15#dropRight
static func drop_right(array, n:int=1):
	if not(array is Array):
		printerr("GD_.drop_right received a non-array type value")
		return null
		
	var size = array.size() - n
	var new_array = []
	var i = 0
	while i < size:
		new_array.append(array[i])
		i += 1
		
	return new_array
	

## Creates a slice of array excluding elements dropped from the end. 
## Elements are dropped until predicate returns falsey. 
## The predicate is invoked with two arguments: (value, index).
## This attempts to replicate lodash's dropRightWhile.
## https://lodash.com/docs/4.17.15#dropRightWhile
static func drop_right_while(array, predicate = null):
	if not(array is Array):
		printerr("GD_.drop_right_while received a non-array type value")
		return null
		
	var new_array = []
	var n = array.size()
	var iter_func = iteratee(predicate)
	while n >= 0:
		n -= 1
		var result = iter_func.call(array[n],n)
		if not(iter_func.call(array[n],n)):
			break
		
	var i = 0
	while i <= n:
		new_array.append(array[i])
		i += 1
		
	return new_array
	
	
## Creates a slice of array excluding elements dropped from the beginning. 
## Elements are dropped until predicate returns falsey. 
## The predicate is invoked with two arguments: (value, index).
## This attempts to replicate lodash's dropWhile.
## https://lodash.com/docs/4.17.15#dropWhile
static func drop_while(array, predicate = null):
	if not(array is Array):
		printerr("GD_.drop_right_while received a non-array type value")
		return null
		
	var new_array = []
	var size = array.size()
	var n = -1
	var iter_func = iteratee(predicate)
	while n < size:
		n += 1
		var result = iter_func.call(array[n],n)
		if not(iter_func.call(array[n],n)):
			break
		
	var i = n
	while i < size:
		new_array.append(array[i])
		i += 1
		
	return new_array
	
## Fills elements of array with value from start up to, but not including, end.
## Note: This method mutates array.
## This attempts to replicate lodash's fill.
## https://lodash.com/docs/4.17.15#fill
static func fill(array, value, start=0, end=-1):
	if not(array is Array):
		printerr("GD_.drop_right_while received a non-array type value")
		return null
		
	if end == -1 or end > array.size():
		end = array.size()

	for i in range(start, end):
		array[i] = value

	return array
	
	
## This method is like GD_.find except that it returns the index of the first 
## element predicate returns truthy for instead of the element itself.
## This attempts to replicate lodash's find_index.
## https://lodash.com/docs/4.17.15#find_index
static func find_index(array, predicate = null, from_index = 0):
	if not(array is Array):
		printerr("GD_.drop_right_while received a non-array type value")
		return null
		
	var iteratee = GD_.iteratee(predicate)
	for i in range(from_index, array.size()):
		if iteratee.call(array[i]):
			return i
	return -1
	
	
## This method is like GD_.findIndex except that it iterates over 
## elements of collection from right to left.
## This attempts to replicate lodash's find_last_index.
## https://lodash.com/docs/4.17.15#find_last_index
static func find_last_index(array, predicate = null, from_index=-1):
	if not(array is Array):
		printerr("GD_.drop_right_while received a non-array type value")
		return null
		
	if from_index == -1 or from_index >= array.size():
		from_index = array.size() - 1

	var iter_func = GD_.iteratee(predicate)
	for i in range(from_index, -1, -1):
		if iter_func.call(array[i]):
			return i
	return -1
	
## Alias to head
## This attempts to replicate lodash's first.
## https://lodash.com/docs/4.17.15#first
static func first(array):
	print("GD_.first is an alias, prefer GD_.head to avoid overhead")
	return head(array)

## Gets the first element of array.
## This attempts to replicate lodash's head.
## https://lodash.com/docs/4.17.15#head
static func head(array):
	if not(array is Array):
		printerr("GD_.head (alias first) received a non-array type value")
		return null

	return array[0] if array.size() else null

## Flattens array a single level deep.
## This attempts to replicate lodash's flatten.
## https://lodash.com/docs/4.17.15#flatten
static func flatten(array): 
	if not(array is Array):
		printerr("GD_.flatten received a non-array type value")
		return null
		
	var new_array = []
	for item in array:
		if item is Array:
			for item2 in item:
				new_array.append(item2)
		else:
			new_array.append(item)
	return new_array
	

## Flattens array a single level deep.
## This attempts to replicate lodash's flatten_deep.
## https://lodash.com/docs/4.17.15#flatten_deep
static func flatten_deep(array):
	if not(array is Array):
		printerr("GD_.flatten_deep received a non-array type value")
		return null
		
	var new_array = array.duplicate()
	var is_flat = false
	while not is_flat:
		is_flat = true
		var tmp = []
		
		for item in new_array:
			if item is Array:
				tmp.append_array(GD_.flatten(item))
				is_flat = false
			else:
				tmp.append(item)
		new_array = tmp
	return new_array
	
		
static func flatten_depth(a=0, b=0, c=0): not_implemented()
static func from_pairs(a=0, b=0, c=0): not_implemented()
static func index_of(a=0, b=0, c=0): not_implemented()
static func initial(a=0, b=0, c=0): not_implemented()
static func intersection(a=0, b=0, c=0): not_implemented()
static func intersection_by(a=0, b=0, c=0): not_implemented()
static func intersection_with(a=0, b=0, c=0): not_implemented()
static func join(a=0, b=0, c=0): not_implemented()
static func last(a=0, b=0, c=0): not_implemented()
static func last_index_of(a=0, b=0, c=0): not_implemented()
static func nth(a=0, b=0, c=0): not_implemented()
static func pull(a=0, b=0, c=0): not_implemented()
static func pull_all(a=0, b=0, c=0): not_implemented()
static func pull_all_by(a=0, b=0, c=0): not_implemented()
static func pull_all_with(a=0, b=0, c=0): not_implemented()
static func pull_at(a=0, b=0, c=0): not_implemented()
static func remove(a=0, b=0, c=0): not_implemented()
static func reverse(a=0, b=0, c=0): not_implemented()
static func slice(a=0, b=0, c=0): not_implemented()
static func sorted_index(a=0, b=0, c=0): not_implemented()
static func sorted_index_by(a=0, b=0, c=0): not_implemented()
static func sorted_index_of(a=0, b=0, c=0): not_implemented()
static func sorted_last_index(a=0, b=0, c=0): not_implemented()
static func sorted_last_index_by(a=0, b=0, c=0): not_implemented()
static func sorted_last_index_of(a=0, b=0, c=0): not_implemented()
static func sorted_uniq(a=0, b=0, c=0): not_implemented()
static func sorted_uniq_by(a=0, b=0, c=0): not_implemented()
static func tail(a=0, b=0, c=0): not_implemented()
static func take(a=0, b=0, c=0): not_implemented()
static func take_right(a=0, b=0, c=0): not_implemented()
static func take_right_while(a=0, b=0, c=0): not_implemented()
static func take_while(a=0, b=0, c=0): not_implemented()
static func union(a=0, b=0, c=0): not_implemented()
static func union_by(a=0, b=0, c=0): not_implemented()
static func union_with(a=0, b=0, c=0): not_implemented()
static func uniq(a=0, b=0, c=0): not_implemented()
static func uniq_by(a=0, b=0, c=0): not_implemented()
static func uniq_with(a=0, b=0, c=0): not_implemented()
static func unzip(a=0, b=0, c=0): not_implemented()
static func unzip_with(a=0, b=0, c=0): not_implemented()
static func without(a=0, b=0, c=0): not_implemented()
static func xor(a=0, b=0, c=0): not_implemented()
static func xor_by(a=0, b=0, c=0): not_implemented()
static func xor_with(a=0, b=0, c=0): not_implemented()
static func zip(a=0, b=0, c=0): not_implemented()
static func zip_object(a=0, b=0, c=0): not_implemented()
static func zip_object_deep(a=0, b=0, c=0): not_implemented()
static func zip_with(a=0, b=0, c=0): not_implemented()

"""
Collections
"""

## Creates a dictionary composed of keys generated from the results of 
## running each element of collection thru iteratee. The corresponding value 
## of each key is the number of times the key was returned by iteratee. 
## The iteratee is invoked with one argument: (value, _UNUSED_).
## This attempts to replicate lodash's count_by. 
## See https://lodash.com/docs/4.17.15#countBy
static func count_by(collection, iteratee = null):
	if not(_is_collection(collection)):
		printerr("GD_.filter received a non-collection type value")
		return null
		
	var iter_func = iteratee(iteratee)
	var counters = {}
	for item in collection:
		var key = str(iter_func.call(item,null))
		if not(counters.has(key)):
			counters[key] = 0
		counters[key] += 1
	return counters


## Alias of for_each
## This attempts to replicate lodash's each.
## https://lodash.com/docs/4.17.15#each
static func each(collection, iteratee): 
	print("GD_.each is an alias, prefer GD_.for_each to avoid overhead")
	return for_each(collection, iteratee)

## Iterates over elements of collection and invokes iteratee for each element. 
## The iteratee is invoked with two arguments: (value, index|key). 
## Iteratee functions may exit iteration early by explicitly returning false.
static func for_each(collection, iteratee): 
	if not(_is_collection(collection)):
		printerr("GD_.for_each received a non-collection type value")
		return null
		
	var iter_func = iteratee(iteratee)
	for key in keyed_iterable(collection):
		var result = iter_func.call(collection[key],key)
		# short circuit
		if is_same(result,false): 
			return

static func each_right(a=0, b=0, c=0): not_implemented()
static func every(a=0, b=0, c=0): not_implemented()

## Iterates over elements of collection, returning an array of all elements predicate returns truthy for. 
## The predicate is invoked with two arguments (value, index|key).
## This attempts to replicate lodash's filter. 
## See https://lodash.com/docs/4.17.15#filter
static func filter(collection, iteratee = null):
	if not(_is_collection(collection)):
		printerr("GD_.filter received a non-collection type value")
		return null
		
	var iter_func = iteratee(iteratee)
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
		printerr("GD_.find received a non-collection type value")
		return null
		
	var iter_func = iteratee(iteratee)
	var index = 0
	for item in collection:
		if index >= from_index and iter_func.call(item,index):
			return item
		index += 1
	return null
	
	
static func find_last(a=0, b=0, c=0): not_implemented()
static func flat_map(a=0, b=0, c=0): not_implemented()
static func flat_map_deep(a=0, b=0, c=0): not_implemented()
static func flat_map_depth(a=0, b=0, c=0): not_implemented()
static func for_each_right(a=0, b=0, c=0): not_implemented()


## Creates a dictionary composed of keys generated from the results of 
## running each element of collection thru iteratee. The order of grouped values is 
## determined by the order they occur in collection. The corresponding value 
## of each key is an array of elements responsible for generating the key. 
## The iteratee is invoked with one argument: (value, _UNUSED_).
## See https://lodash.com/docs/4.17.15#groupBy
static func group_by(collection, iteratee = null):
	if not(_is_collection(collection)):
		printerr("GD_.filter received a non-collection type value")
		return null
		
	var iter_func = iteratee(iteratee)
	var counters = {}
	for item in collection:
		var key = str(iter_func.call(item,null))
		if not(counters.has(key)):
			counters[key] = []
		counters[key].append(item)
	return counters
	
	
static func includes(a=0, b=0, c=0): not_implemented()
static func invoke_map(a=0, b=0, c=0): not_implemented()
static func key_by(a=0, b=0, c=0): not_implemented()


static func map(collection, iteratee):
	if not(_is_collection(collection)):
		printerr("GD_.map received a non-collection type value")
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
	
	
static func order_by(a=0, b=0, c=0): not_implemented()
static func partition(a=0, b=0, c=0): not_implemented()
static func reduce(a=0, b=0, c=0): not_implemented()
static func reduce_right(a=0, b=0, c=0): not_implemented()
static func reject(a=0, b=0, c=0): not_implemented()
static func sample(a=0, b=0, c=0): not_implemented()
static func sample_size(a=0, b=0, c=0): not_implemented()
static func shuffle(a=0, b=0, c=0): not_implemented()
static func size(a=0, b=0, c=0): not_implemented()

## Checks if predicate returns truthy for any element of collection. 
## Iteration is stopped once predicate returns truthy. 
## The predicate is invoked with two arguments: (value, index|key).
## This attempts to replicate lodash's some. 
## See https://lodash.com/docs/4.17.15#some
static func some(collection, iteratee = null):
	if not(_is_collection(collection)):
		printerr("GD_.some received a non-collection type value")
		return null
		
	var iter_func = iteratee(iteratee)
	var index = 0
	for item in collection:
		if iter_func.call(item,index):
			return true
		index += 1
	return false
	
	
static func sort_by(a=0, b=0, c=0): not_implemented()

"""
Date
"""
static func now(a=0, b=0, c=0): not_implemented()
"""
Function
"""
static func after(a=0, b=0, c=0): not_implemented()
static func ary(a=0, b=0, c=0): not_implemented()
static func before(a=0, b=0, c=0): not_implemented()
static func bind(a=0, b=0, c=0): not_implemented()
static func bind_key(a=0, b=0, c=0): not_implemented()
static func curry(a=0, b=0, c=0): not_implemented()
static func curry_right(a=0, b=0, c=0): not_implemented()
static func debounce(a=0, b=0, c=0): not_implemented()
static func defer(a=0, b=0, c=0): not_implemented()
static func delay(a=0, b=0, c=0): not_implemented()
static func flip(a=0, b=0, c=0): not_implemented()
static func memoize(a=0, b=0, c=0): not_implemented()
static func negate(a=0, b=0, c=0): not_implemented()
static func once(a=0, b=0, c=0): not_implemented()
static func over_args(a=0, b=0, c=0): not_implemented()
static func partial(a=0, b=0, c=0): not_implemented()
static func partial_right(a=0, b=0, c=0): not_implemented()
static func rearg(a=0, b=0, c=0): not_implemented()
static func rest(a=0, b=0, c=0): not_implemented()
static func spread(a=0, b=0, c=0): not_implemented()
static func throttle(a=0, b=0, c=0): not_implemented()
static func unary(a=0, b=0, c=0): not_implemented()
static func wrap_func(a=0, b=0, c=0): not_implemented()
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
	
		
static func clone(a=0, b=0, c=0): not_implemented()
static func clone_deep(a=0, b=0, c=0): not_implemented()
static func clone_deep_with(a=0, b=0, c=0): not_implemented()
static func clone_with(a=0, b=0, c=0): not_implemented()
static func conforms_to(a=0, b=0, c=0): not_implemented()
static func eq(a=0, b=0, c=0): not_implemented()
static func gt(a=0, b=0, c=0): not_implemented()
static func gte(a=0, b=0, c=0): not_implemented()
static func is_arguments(a=0, b=0, c=0): not_implemented()
static func is_array(a=0, b=0, c=0): not_implemented()
static func is_array_buffer(a=0, b=0, c=0): not_implemented()
static func is_array_like(a=0, b=0, c=0): not_implemented()
static func is_array_like_object(a=0, b=0, c=0): not_implemented()
static func is_boolean(a=0, b=0, c=0): not_implemented()
static func is_buffer(a=0, b=0, c=0): not_implemented()
static func is_date(a=0, b=0, c=0): not_implemented()
static func is_element(a=0, b=0, c=0): not_implemented()
static func is_empty(a=0, b=0, c=0): not_implemented()
static func is_equal(a=0, b=0, c=0): not_implemented()
static func is_equal_with(a=0, b=0, c=0): not_implemented()
static func is_error(a=0, b=0, c=0): not_implemented()
#static func is_finite(a=0, b=0, c=0): not_implemented()
static func is_function(a=0, b=0, c=0): not_implemented()
static func is_integer(a=0, b=0, c=0): not_implemented()
static func is_length(a=0, b=0, c=0): not_implemented()
static func is_map(a=0, b=0, c=0): not_implemented()
static func is_match(a=0, b=0, c=0): not_implemented()
static func is_match_with(a=0, b=0, c=0): not_implemented()
#static func is_nan(a=0, b=0, c=0): not_implemented()
static func is_native(a=0, b=0, c=0): not_implemented()
static func is_nil(a=0, b=0, c=0): not_implemented()
static func is_null(a=0, b=0, c=0): not_implemented()
static func is_number(a=0, b=0, c=0): not_implemented()
static func is_object(a=0, b=0, c=0): not_implemented()
static func is_object_like(a=0, b=0, c=0): not_implemented()
static func is_plain_object(a=0, b=0, c=0): not_implemented()
static func is_reg_exp(a=0, b=0, c=0): not_implemented()
static func is_safe_integer(a=0, b=0, c=0): not_implemented()
static func is_set(a=0, b=0, c=0): not_implemented()
static func is_string(a=0, b=0, c=0): not_implemented()
static func is_symbol(a=0, b=0, c=0): not_implemented()
static func is_typed_array(a=0, b=0, c=0): not_implemented()
static func is_undefined(a=0, b=0, c=0): not_implemented()
static func is_weak_map(a=0, b=0, c=0): not_implemented()
static func is_weak_set(a=0, b=0, c=0): not_implemented()
static func lt(a=0, b=0, c=0): not_implemented()
static func lte(a=0, b=0, c=0): not_implemented()
static func to_array(a=0, b=0, c=0): not_implemented()
static func to_finite(a=0, b=0, c=0): not_implemented()
static func to_integer(a=0, b=0, c=0): not_implemented()
static func to_length(a=0, b=0, c=0): not_implemented()
static func to_number(a=0, b=0, c=0): not_implemented()
static func to_plain_object(a=0, b=0, c=0): not_implemented()
static func to_safe_integer(a=0, b=0, c=0): not_implemented()
#static func to_string(a=0, b=0, c=0): not_implemented()

"""
MATH
"""
static func add(a=0, b=0, c=0): not_implemented()
#static func ceil(a=0, b=0, c=0): not_implemented()
static func divide(a=0, b=0, c=0): not_implemented()

## Computes number rounded down to precision.
## This is renamed to floor_ because it conflicts with
## Godot's floor function.
## This attempts to replicate lodash's some. 
## See https://lodash.com/docs/4.17.15#some
static func floor(number, precision = 0):
	var scale = pow(10.0, precision)
	return __floor(number * scale) / scale
	
#static func max(a=0, b=0, c=0): not_implemented()
static func max_by(a=0, b=0, c=0): not_implemented()
static func mean(a=0, b=0, c=0): not_implemented()
static func mean_by(a=0, b=0, c=0): not_implemented()
#static func min(a=0, b=0, c=0): not_implemented()
static func min_by(a=0, b=0, c=0): not_implemented()
static func multiply(a=0, b=0, c=0): not_implemented()
#static func round(a=0, b=0, c=0): not_implemented()
static func subtract(a=0, b=0, c=0): not_implemented()
static func sum(a=0, b=0, c=0): not_implemented()
static func sum_by(a=0, b=0, c=0): not_implemented()


"""
NUMBER
"""

#static func clamp(a=0, b=0, c=0): not_implemented()
static func in_range(a=0, b=0, c=0): not_implemented()
static func random(a=0, b=0, c=0): not_implemented()

"""
OBJECT
"""
static func assign(a=0, b=0, c=0): not_implemented()
static func assign_in(a=0, b=0, c=0): not_implemented()
static func assign_in_with(a=0, b=0, c=0): not_implemented()
static func assign_with(a=0, b=0, c=0): not_implemented()
static func at(a=0, b=0, c=0): not_implemented()
static func create(a=0, b=0, c=0): not_implemented()
static func defaults(a=0, b=0, c=0): not_implemented()
static func defaults_deep(a=0, b=0, c=0): not_implemented()
static func to_pairs(a=0, b=0, c=0): not_implemented() # alias for entries
static func to_pairs_in(a=0, b=0, c=0): not_implemented() # alias for entriesIn
static func find_key(a=0, b=0, c=0): not_implemented()
static func find_last_key(a=0, b=0, c=0): not_implemented()
static func for_in(a=0, b=0, c=0): not_implemented()
static func for_in_right(a=0, b=0, c=0): not_implemented()
static func for_own(a=0, b=0, c=0): not_implemented()
static func for_own_right(a=0, b=0, c=0): not_implemented()
static func functions(a=0, b=0, c=0): not_implemented()
static func functions_in(a=0, b=0, c=0): not_implemented()
#static func get(a=0, b=0, c=0): not_implemented()
static func has(a=0, b=0, c=0): not_implemented()
static func has_in(a=0, b=0, c=0): not_implemented()
static func invert(a=0, b=0, c=0): not_implemented()
static func invert_by(a=0, b=0, c=0): not_implemented()
static func invoke(a=0, b=0, c=0): not_implemented()
static func keys(a=0, b=0, c=0): not_implemented()
static func keys_in(a=0, b=0, c=0): not_implemented()
static func map_keys(a=0, b=0, c=0): not_implemented()
static func map_values(a=0, b=0, c=0): not_implemented()
static func merge(a=0, b=0, c=0): not_implemented()
static func merge_with(a=0, b=0, c=0): not_implemented()
static func omit(a=0, b=0, c=0): not_implemented()
static func omit_by(a=0, b=0, c=0): not_implemented()
static func pick(a=0, b=0, c=0): not_implemented()
static func pick_by(a=0, b=0, c=0): not_implemented()
static func result(a=0, b=0, c=0): not_implemented()
#static func set(a=0, b=0, c=0): not_implemented()
static func set_with(a=0, b=0, c=0): not_implemented()
#static func to_pairs(a=0, b=0, c=0): not_implemented()
#static func to_pairs_in(a=0, b=0, c=0): not_implemented()
static func transform(a=0, b=0, c=0): not_implemented()
static func unset(a=0, b=0, c=0): not_implemented()
static func update(a=0, b=0, c=0): not_implemented()
static func update_with(a=0, b=0, c=0): not_implemented()
static func values(a=0, b=0, c=0): not_implemented()
static func values_in(a=0, b=0, c=0): not_implemented()

"""
UTILS
"""

static func attempt(a=0, b=0, c=0): not_implemented()
static func bind_all(a=0, b=0, c=0): not_implemented()
static func cond(a=0, b=0, c=0): not_implemented()
static func conforms(a=0, b=0, c=0): not_implemented()
static func constant(a=0, b=0, c=0): not_implemented()
static func default_to(a=0, b=0, c=0): not_implemented()
static func flow(a=0, b=0, c=0): not_implemented()
static func flow_right(a=0, b=0, c=0): not_implemented()

## This method returns the first argument it receives.
## This attempts to replicate lodash's identity. 
## https://lodash.com/docs/4.17.15#identity
static func identity(value, _unused = null): 
	return value
	
## Converts shorthands to callables for use in other funcs
## This attempts to replicate lodash's iteratee. 
## https://lodash.com/docs/4.17.15#iteratee
static func iteratee(iteratee_val):
	match typeof(iteratee_val):
		TYPE_DICTIONARY:
			return matches(iteratee_val)
		TYPE_STRING:
			return property(iteratee_val)
		TYPE_ARRAY:
			var prop = _property(["0"],iteratee_val)
			var val = _property(["1"],iteratee_val)
			return matches_property(prop,val)
		TYPE_NIL:
			return GD_.identity
		TYPE_CALLABLE:
			return iteratee_val
				
		_:
			printerr("GD_.find called with unsupported signature %s. See docs for more info" % iteratee)
	return null


static func matches(dict:Dictionary) -> Callable:
	return func (value, _unused = null):
		var found = true
		for key in dict:
			var prop = value.get(key)
			found = found and dict[key] == prop
		return found
		
static func matches_property(string:String, v):
	var splits = string.split(":")
	return func (value, _unused = null):
		return _property(splits,value) == v
		
		
static func method(a=0, b=0, c=0): not_implemented()
static func method_of(a=0, b=0, c=0): not_implemented()
static func mixin(a=0, b=0, c=0): not_implemented()
static func no_conflict(a=0, b=0, c=0): not_implemented()

static func noop(a=0,b=0,c=0,d=0,e=0,f=0,g=0,h=0,i=0,j=0,k=0,l=0,m=0,n=0,o=0,p=0): 
	pass
			
static func nth_arg(a=0, b=0, c=0): not_implemented()
static func over(a=0, b=0, c=0): not_implemented()
static func over_every(a=0, b=0, c=0): not_implemented()
static func over_some(a=0, b=0, c=0): not_implemented()

## Creates a function that returns the value at path of a given object.	
## T
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
	
		
static func property_of(a=0, b=0, c=0): not_implemented()
#static func range(a=0, b=0, c=0): not_implemented()
static func range_right(a=0, b=0, c=0): not_implemented()
static func run_in_context(a=0, b=0, c=0): not_implemented()
static func stub_array(a=0, b=0, c=0): not_implemented()
static func stub_false(a=0, b=0, c=0): not_implemented()
static func stub_object(a=0, b=0, c=0): not_implemented()
static func stub_string(a=0, b=0, c=0): not_implemented()
static func stub_true(a=0, b=0, c=0): not_implemented()
static func times(a=0, b=0, c=0): not_implemented()
static func to_path(a=0, b=0, c=0): not_implemented()
static func unique_id(a=0, b=0, c=0): not_implemented()

"""
NON-LODASH FUNCS
"""

## Ensures that when it iterates through the item, it always iterates via keys
## This does not have a lodash equivalent	
static func keyed_iterable(thing):
	if thing is Array:
		return range(thing.size())
	elif thing is Dictionary:
		return thing
		
	printerr("_to_collection received a non-collection")
	return []

"""
INTERNAL
"""
static func _is_collection(item):
	return item is Array or item is Dictionary
