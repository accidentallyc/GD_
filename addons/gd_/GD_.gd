extends "./GD_base.gd"

class_name GD_

"""
CATEGORY: Array
"""

## Creates an array of elements split into groups the length of size. 
## If array can't be split evenly, the final chunk will be the remaining elements.
##
## Arguments
## 		array (Array): The array to process.
## 		[size=1] (number): The length of each chunk
## Returns
## 		(Array): Returns the new array of chunks.
## Example
## 		GD_.chunk(['a', 'b', 'c', 'd'], 2)
## 		# => [['a', 'b'], ['c', 'd']]
## 		 
## 		GD_.chunk(['a', 'b', 'c', 'd'], 3)
## 		# => [['a',* 'b', 'c'], ['d']]
## Notes
##		>> Credit
##			Thanks to cyberreality for the quick code they offered to the community
##			https://www.reddit.com/r/godot/comments/e6ae27/comment/f9p3c2e
## 		>> @TODO guarded method by map, every, filter, mapValues, reject, some
static func chunk(array:Array,size=1): 
    return __INTERNAL__.base_chunk(array,size)
                
                
## Creates an array with all falsey values removed. 
## The falsiness is determined by a basic if statement.
## The values false, null, 0, "", [], and {} are falsey.
##
## Arguments
## 		array (Array): The array to process.
## 		[size=1] (number): The length of each chunk
## Returns
## 		(Array): Returns the new array of chunks.
## Example
## 		GD_.compact([0, 1, false, 2, '', 3])
## 		# => [1, 2, 3]
static func compact(array:Array):
    return __INTERNAL__.base_compact(array)
        
        
## Creates a new array concatenating array with any additional arrays and/or values.
## This func can receive up to 10 concat values. Hopefully thats enough
##
## Arguments
## 		array (Array): The array to concatenate.
## 		[values] (...*): The values to concatenate.
## Returns
## 		(Array): Returns the new concatenated array.
## Example
## 		var array = [1]
## 		var other = GD_.concat(array, 2, [3], [[4]])
## 		 
## 		print(other)
## 		# => [1, 2, 3, [4]]
## 		 
## 		print(array)
## 		# => [1]
static func concat(array:Array, a=_UNDEF_,b=_UNDEF_,c=_UNDEF_,d=_UNDEF_,e=_UNDEF_,f=_UNDEF_,g=_UNDEF_,h=_UNDEF_,i=_UNDEF_,j=_UNDEF_,k=_UNDEF_):
    return __INTERNAL__.base_concat(array,[a,b,c,d,e,f,g,h,i,j,k])
                
            
## Creates an array of array values not included in the other given arrays 
## using == for comparisons. The order and references of result values 
## are determined by the first array.
##
## Arguments
##			array (Array): The array to inspect.
##			[values] (...Array): The values to exclude.
## Returns
##			(Array): Returns the new array of filtered values.
## Example
##			GD_.difference([2, 1], [2, 3])
##			# => [1]
static func difference(array_left:Array, array_right:Array): 	
    return __INTERNAL__.base_difference(array_left,array_right)

## This method is like GD_.difference except that it accepts iteratee which 
## is invoked for each element of array and values to generate the criterion 
## by which they're compared using ==. The order and references of result 
## values are determined by the first array. The iteratee is 
## invoked with two arguments: (value, _UNUSED_)
##
## Arguments
##		array (Array): The array to inspect.
##		[values] (...Array): The values to exclude.
##		[iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
##		(Array): Returns the new array of filtered values.
## Example
## 		GD_.difference_by([2.1, 1.2], [2.3, 3.4], Math.floor)
## 		# => [1.2]
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.difference_by([{ 'x': 2 }, { 'x': 1 }], [{ 'x': 1 }], 'x')
## 		# => [{ 'x': 2 }]
static func difference_by(array_left, array_right, iteratee = GD_.identity): 
    return __INTERNAL__.base_difference_by(array_left, array_right, iteratee)
    
    
## This method is like GD_.difference except that it accepts comparator 
## which is invoked to compare elements of array to values. 
## The order and references of result values are determined by the first array. 
## The comparator is invoked with two arguments: (arrVal, othVal).
##
## Arguments
## 		array (Array): The array to inspect.
## 		[values] (...Array): The values to exclude.
## 		[comparator] (Function): The comparator invoked per element.
## Returns
## 		(Array): Returns the new array of filtered values.
## Example
## 		var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]
## 		 
## 		GD_.difference_with(objects, [{ 'x': 1, 'y': 2 }], GD_.is_equal)
## 		# => [{ 'x': 2, 'y': 1 }]
static func difference_with(array_left, array_right, comparator:Callable): 
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
##
## Arguments
## 		array (Array): The array to query.
## 		[n=1] (number): The number of elements to drop.
## Returns
## 		(Array): Returns the slice of array.
## Example
## 		GD_.drop([1, 2, 3])
## 		# => [2, 3]
## 		 
## 		GD_.drop([1, 2, 3], 2)
## 		# => [3]
## 		 
## 		GD_.drop([1, 2, 3], 5)
## 		# => []
## 		 
## 		GD_.drop([1, 2, 3], 0)
## 		# => [1, 2, 3]
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func drop(array:Array, n:int=1): 
    var size = array.size()
    var new_array = []
    for i in range(n,size):
        new_array.append(array[i])
        i += 1
        
    return new_array
    
    
## Creates a slice of array with n elements dropped from the beginning.
## 
## Arguments
## 		array (Array): The array to query.
## 		[n=1] (number): The number of elements to drop.
## Returns
## 		(Array): Returns the slice of array.
## Example
## 		GD_.drop_right([1, 2, 3])
## 		# => [1, 2]
## 		
## 		GD_.drop_right([1, 2, 3], 2)
## 		# => [1]
## 		 
## 		GD_.drop_right([1, 2, 3], 5)
## 		# => []
## 		 
## 		GD_.drop_right([1, 2, 3], 0)
## 		# => [1, 2, 3]
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func drop_right(array:Array, n:int=1): 
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
##
## Arguments
## 		array (Array): The array to query.
## 		[predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
## 		(Array): Returns the slice of array.
## Example
## 		var users = [
## 		  { 'user': 'barney',  'active': true },
## 		  { 'user': 'fred',    'active': false },
## 		  { 'user': 'pebbles', 'active': false }
## 		]
## 		 
## 		GD_.drop_right_while(users, func (o,_unused): return !o.active)
## 		# => objects for ['barney']
## 		 
## 		# The `GD_.matches` iteratee shorthand.
## 		GD_.drop_right_while(users, { 'user': 'pebbles', 'active': false })
## 		# => objects for ['barney', 'fred']
## 		 
## 		# The `GD_.matches_property` iteratee shorthand.
## 		GD_.drop_right_while(users, ['active', false])
## 		# => objects for ['barney']
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.drop_right_while(users, 'active')
## 		# => objects for ['barney', 'fred', 'pebbles']
static func drop_right_while(array:Array, predicate = GD_.identity):
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
##
## Arguments
## 		array (Array): The array to query.
## 		[predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
## 		(Array): Returns the slice of array.
## Example
## 		var users = [
## 		  { 'user': 'barney',  'active': false },
## 		  { 'user': 'fred',    'active': false },
## 		  { 'user': 'pebbles', 'active': true }
## 		]
## 		 
## 		GD_.drop_while(users, func (o, _unused): return !o.active )
## 		# => objects for ['pebbles']
## 		 
## 		# The `GD_.matches` iteratee shorthand.
## 		GD_.drop_while(users, { 'user': 'barney', 'active': false })
## 		# => objects for ['fred', 'pebbles']
## 		 
## 		# The `GD_.matches_property` iteratee shorthand.
## 		GD_.drop_while(users, ['active', false])
## 		# => objects for ['pebbles']
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.drop_while(users, 'active')
## 		# => objects for ['barney', 'fred', 'pebbles']
static func drop_while(array:Array, predicate = GD_.identity):
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
##
## Arguments
## 		array (Array): The array to fill.
## 		value (*): The value to fill array with.
## 		[start=0] (number): The start position.
## 		[end=array.length] (number): The end position.
## Returns
## 		(Array): Returns array.
## Example
## 		var array = [1, 2, 3]
## 		 
## 		GD_.fill(array, 'a')
## 		print(array)
## 		# => ['a', 'a', 'a']
## 		 
## 		GD_.fill(Array(3), 2)
## 		# => [2, 2, 2]
## 		 
## 		GD_.fill([4, 6, 8, 10], '*', 1, 3)
## 		# => [4, '*', '*', 10]
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func fill(array:Array, value, start=0, end=-1): 
    if end == -1 or end > array.size():
        end = array.size()

    for i in range(start, end):
        array[i] = value

    return array
    
    
## This method is like GD_.find except that it returns the index of the first 
## element predicate returns truthy for instead of the element itself.
##
## Arguments
## 		array (Array): The array to inspect.
## 		[predicate=GD_.identity] (Function): The function invoked per iteration.
## 		[fromIndex=0] (number): The index to search from.
## Returns
## 		(number): Returns the index of the found element, else -1.
## Example
## 		var users = [
## 		  { 'user': 'barney',  'active': false },
## 		  { 'user': 'fred',    'active': false },
## 		  { 'user': 'pebbles', 'active': true }
## 		]
## 		 
## 		GD_.find_index(users, func (o, _i): return o.user == 'barney' )
## 		# => 0
## 		 
## 		# The `GD_.matches` iteratee shorthand.
## 		GD_.find_index(users, { 'user': 'fred', 'active': false })
## 		# => 1
## 		 
## 		# The `GD_.matches_property` iteratee shorthand.
## 		GD_.find_index(users, ['active', false])
## 		# => 0
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.find_index(users, 'active')
## 		# => 2
static func find_index(array:Array, predicate = GD_.identity, from_index = 0):
    var iteratee = GD_.iteratee(predicate)
    for i in range(from_index, array.size()):
        if iteratee.call(array[i], null):
            return i
    return -1
    
    
## This method is like GD_.findIndex except that it iterates over 
## elements of collection from right to left.
##
## Arguments
## 		array (Array): The array to inspect.
## 		[predicate=GD_.identity] (Function): The function invoked per iteration.
## 		[fromIndex=array.length-1] (number): The index to search from.
## Returns
## 		(number): Returns the index of the found element, else -1.
## Example
## 		var users = [
## 		  { 'user': 'barney',  'active': true },
## 		  { 'user': 'fred',    'active': false },
## 		  { 'user': 'pebbles', 'active': false }
## 		]
## 		 
## 		GD_.find_last_index(users, func(o,_index): return o.user == 'pebbles')
## 		# => 2
## 		 
## 		# The `GD_.matches` iteratee shorthand.
## 		GD_.find_last_index(users, { 'user': 'barney', 'active': true })
## 		# => 0
## 		 
## 		# The `GD_.matches_property` iteratee shorthand.
## 		GD_.find_last_index(users, ['active', false])
## 		# => 2
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.find_last_index(users, 'active')
## 		# => 0
static func find_last_index(array:Array, predicate = GD_.identity, from_index=-1):
    if from_index == -1 or from_index >= array.size():
        from_index = array.size() - 1

    var iter_func = GD_.iteratee(predicate)
    for i in range(from_index, -1, -1):
        if iter_func.call(array[i],null):
            return i
    return -1
    
    
## Alias to head
static func first(array):
    gd_warn("GD_.first is an alias, prefer GD_.head to avoid overhead")
    return head(array)


## Flattens array a single level deep.
##
## Arguments
## 		array (Array): The array to flatten.
## Returns
## 		(Array): Returns the new flattened array.
## Example
## 		GD_.flatten([1, [2, [3, [4]], 5]])
## 		# => [1, 2, [3, [4]], 5]
static func flatten(array:Array): 
    return flatten_depth(array, 1)
    

## Recursively flattens array.
##
## Arguments
## 		array (Array): The array to flatten.
## Returns
## 		(Array): Returns the new flattened array.
## Example
##		GD_.flatten_deep([1, [2, [3, [4]], 5]])
##		# => [1, 2, 3, 4, 5]
static func flatten_deep(array:Array):
    return flatten_depth(array, INF)
    

## Recursively flatten array up to depth times.
##
## Arguments
## 		array (Array): The array to flatten.
## 		[depth=1] (number): The maximum recursion depth.
## Returns
## 		(Array): Returns the new flattened array.
## Example
## 		var array = [1, [2, [3, [4]], 5]]
## 		 
## 		GD_.flatten_depth(array, 1)
## 		# => [1, 2, [3, [4]], 5]
## 		 
## 		GD_.flatten_depth(array, 2)
## 		# => [1, 2, 3, [4], 5]
static func flatten_depth(array:Array, depth = 1):
    var new_array = array.duplicate()
    var current_depth = 0

    while current_depth < depth:
        var is_flat = true
        var tmp = []

        for item in new_array:
            if item is Array:
                tmp.append_array(item)
                is_flat = false
            else:
                tmp.append(item)
        
        new_array = tmp
        if is_flat:
            break
        current_depth += 1

    return new_array
    
    
## The inverse of GD_.to_pairs.
## This method returns an object composed from key-value pairs.
##
## Arguments
## 		pairs (Array): The key-value pairs.
## Returns
## 		(Object): Returns the new object.
## Example
##		GD_.from_pairs([['a', 1], ['b', 2]])
##		# => { 'a': 1, 'b': 2 }
static func from_pairs(array:Array): 
    var obj = {}
    for i in array:
        if not(i is Array) or i.size() != 2:
            gd_warn("GD_.from_pairs entry must follow this [k,v]. Received %s instead" % i )
            continue
            
        obj[i[0]] = i[1]
    return obj
    
    
## Gets the first element of array.
## 
## Aliases
## 		GD_.first
## Arguments
## 		array (Array): The array to query.
## Returns
## 		(*): Returns the first element of array.
## Example
##		GD_.head([1, 2, 3])
##		# => 1
##		 
##		GD_.head([])
##		# => null
static func head(array:Array):
    return array[0] if array.size() else null
    

## Gets the index at which the first occurrence of value is found in array 
## using == for equality comparisons. If fromIndex is negative, 
## it's used as the offset from the end of array.
##
## Arguments
## 		array (Array): The array to inspect.
## 		value (*): The value to search for.
## 		[fromIndex=0] (number): The index to search from.
## Returns
## 		(number): Returns the index of the matched value, else -1.
## Example
##		GD_.index_of([1, 2, 1, 2], 2)
##		# => 1
##		 
##		# Search from the `fromIndex`.
##		GD_.index_of([1, 2, 1, 2], 2, 2)
##		# => 3
static func index_of(array:Array, search, from_index = 0 ): 
    var size = array.size()
    if from_index < 0:
        from_index = max(size + from_index, 0)
    
    for i in range(from_index, size):
        if array[i] == search:
            return i
    return -1
    
## Gets all but the last element of array.
##
## Arguments
## 		array (Array): The array to query.
## Returns
## 		(Array): Returns the slice of array.
## 	Example
##		GD_.initial([1, 2, 3])
##		# => [1, 2]
static func initial(array:Array):
    var copy = array.duplicate() 
    copy.pop_back()
    return copy
    

## Creates an array of unique values that are included in all given 
## arrays using == for equality comparisons. The order and references of 
## result values are determined by the first array.
##
## Arguments
## 		[arrays] (...Array): The arrays to inspect.
## Returns
## 		(Array): Returns the new array of intersecting values.
## Example
## 		GD_.intersection([2, 1], [2, 3])
## 		# => [2]
static func intersection(array_1:Array,array_2:Array,array_3 = null,array_4 = null,array_5 = null,array_6 = null,array_7 = null,array_8 = null,array_9 = null,array_10 = null,array_11 = null):
    if not(array_1 is Array):
        gd_warn("GD_.intersection received a non-array type value")
        return null
    if not array_2 is Array:
        gd_warn("GD_.intersection received a non-array type value for array_2")
        return null
    return intersection_with(array_1,array_2,array_3,array_4,array_5,array_6,array_7,array_8,array_9,array_10,array_11)

    
## This method is like GD_.intersection except that it accepts iteratee 
## which is invoked for each element of each arrays to generate the 
## criterion by which they're compared. The order and references of result 
## values are determined by the first array. The iteratee is invoked 
## with one argument: (value)
##
## Arguments
## 		[arrays] (...Array): The arrays to inspect.
## 		[iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
## 		(Array): Returns the new array of intersecting values.
## Example
##		GD_.intersection_by([2.1, 1.2], [2.3, 3.4], GD_.floor)
##		# => [2.1]
##		 
##		# The `GD_.property` iteratee shorthand.
##		GD_.intersection_by([{ 'x': 1 }], [{ 'x': 2 }, { 'x': 1 }], 'x')
##		# => [{ 'x': 1 }]
static func intersection_by(array_1:Array, array_2:Array, array_3 = null, array_4 = null, array_5 = null, array_6 = null, array_7 = null, array_8 = null, array_9 = null, array_10 = null):
    if not array_1 is Array:
        gd_warn("GD_.intersection_by received a non-array type value for array_1")
        return null
    if not array_2 is Array:
        gd_warn("GD_.intersection_by received a non-array type value for array_2")
        return null

    var arrays = [array_2, array_3, array_4, array_5, array_6, array_7, array_8, array_9, array_10]
    var iteratee = GD_.identity
    var max = 1

    for i in arrays.size():
        max = i
        if arrays[i] == null:
            # Previous is the iteratee
            iteratee = iteratee(arrays[i - 1])
            max -= 1
            break

    var left_array = array_1
    for i in max:
        var right_array = arrays[i]
        var tmp = []
        for left_value in left_array:
            var transformed_left = iteratee.call(left_value,null)
            for right_value in right_array:
                var transformed_right = iteratee.call(right_value,null)
                if transformed_left == transformed_right and left_value not in tmp:
                    tmp.append(left_value)
                    break
        left_array = tmp
    return left_array


## This method is like GD_.intersection except that it accepts comparator 
## which is invoked to compare elements of arrays. The order and references of 
## result values are determined by the first array. The comparator is invoked 
## with two arguments: (arrVal, othVal).
## You can "intersect" with up to 10 values. Hopefully thats enough
## 
## Arguments
## 		[arrays] (...Array): The arrays to inspect.
## 		[comparator] (Function): The comparator invoked per element.
## Returns
## 		(Array): Returns the new array of intersecting values.
## Example
## 		var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]
## 		var others = [{ 'x': 1, 'y': 1 }, { 'x': 1, 'y': 2 }]
## 		 
## 		GD_.intersection_with(objects, others, GD_.is_equal)
## 		# => [{ 'x': 1, 'y': 2 }]
static func intersection_with(array_1:Array,array_2:Array,array_3 = null,array_4 = null,array_5 = null,array_6 = null,array_7 = null,array_8 = null,array_9 = null,array_10 = null,array_11 = null):
    if not(array_1 is Array):
        gd_warn("GD_.intersection_with received a non-array type value")
        return null
    if not(array_2 is Array):
        gd_warn("GD_.intersection_with received a non-array type value")
        return null
        
    var arrays = [array_2,array_3, array_4,array_5,array_6,array_7,
            array_8,array_9,array_10,array_11 ]
        
    var comparator = GD_.is_equal
    var max = 1
    for i in arrays.size():
        max = i
        if arrays[i] is Callable:
            comparator = arrays[i]
            break
        if arrays[i] == null:
            break
        
    var left_array = array_1
    for i in max:
        var right_array = arrays[i]
        var tmp = []
        for left_value in left_array:
            for right_value in right_array:
                if comparator.call(left_value,right_value) and left_value not in tmp:
                    tmp.append(left_value)
                    break
        left_array = tmp
    return left_array
    
    
## Converts all elements in array into a string separated by separator.
## 
## Arguments
## 		array (Array): The array to convert.
## 		[separator=','] (string): The element separator.
## Returns
## 		(string): Returns the joined string.
## Example
## 		GD_.join(['a', 'b', 'c'], '~')
## 		# => 'a~b~c'
static func join(array:Array, separator=&','):
    return separator.join(array)
        
        
## Gets the last element of array.
##
## Arguments
## 		array (Array): The array to query.
## Returns
## 		(*): Returns the last element of array.
## Example
## 		GD_.last([1, 2, 3])
## 		# => 3
static func last(array:Array):
    return array.back()
    
    
## This method is like GD_.index_of except that it iterates 
## over elements of array from right to left.
##
## Arguments
## 		array (Array): The array to inspect.
## 		value (*): The value to search for.
## 		[fromIndex=array.length-1] (number): The index to search from.
## Returns
## 		(number): Returns the index of the matched value, else -1.
## Example
## 		GD_.last_index_of([1, 2, 1, 2], 2)
## 		# => 3
## 		 
## 		# Search from the from_index`.
## 		GD_.last_index_of([1, 2, 1, 2], 2, 2)
## 		# => 1
static func last_index_of(array:Array, search, from_index = null ): 
    var size = array.size()
    from_index = GD_.default_to(from_index, size -1)
    if from_index < 0:
        from_index = max(size + from_index, 0)
    
    for i in range(from_index, -1, -1):
        if array[i] == search:
            return i
    return -1
    

## Gets the element at index n of array. 
## If n is negative, the nth element from the end is returned.
## 
## Arguments
## 		array (Array): The array to query.
## 		[n=0] (number): The index of the element to return.
## Returns
## 		(*): Returns the nth element of array.
## Example
## 		var array = ['a', 'b', 'c', 'd']
## 		 
## 		GD_.nth(array, 1)
## 		# => 'b'
## 		 
## 		GD_.nth(array, -2)
## 		# => 'c'
static func nth(array:Array, n=0):
    var count = array.size()
    var index =  count + n  if n < 0 else n
    if index >= 0 and index < count:
        return array[index]
    return null
        
        
## Removes all given values from array using == for equality comparisons.
##
## Note: Unlike _.without, this method mutates array. 
## Use _.remove to remove elements from an array by predicate
##
## Arguments
## 		array (Array): The array to modify.
## 		[values] (...*): The values to remove.
## Returns
## 		(Array): Returns array.
## Example
## 		var array = ['a', 'b', 'c', 'a', 'b', 'c']
## 		 
## 		GD_.pull(array, 'a', 'c')
## 		print(array)
## 		# => ['b', 'b']
static func pull(array:Array, a=_UNDEF_,b=_UNDEF_,c=_UNDEF_,d=_UNDEF_,e=_UNDEF_,f=_UNDEF_,g=_UNDEF_,h=_UNDEF_,i=_UNDEF_,j=_UNDEF_): 
    var to_remove = GD_.filter([a,b,c,d,e,f,g,h,i,j], GD_._is_not_null_arg)
    return pull_all_by(array, to_remove)
    

## This method is like _.pull except that it accepts an array of values to remove.
## Note: Unlike _.difference, this method mutates array.
## 
## Arguments
## 		array (Array): The array to modify.
## 		values (Array): The values to remove.
## Returns
## 		(Array): Returns array.
## Example
## 		var array = ['a', 'b', 'c', 'a', 'b', 'c']
## 		 
## 		GD_.pull_all(array, ['a', 'c'])
## 		print(array)
## 		# => ['b', 'b']
static func pull_all(array:Array, values_to_remove:Array = _EMPTY_ARRAY_): 				
    return pull_all_by(array, values_to_remove)
    
## This method is like GD_.pull_all except that it accepts iteratee 
## which is invoked for each element of array and values to generate 
## the criterion by which they're compared. The iteratee is invoked 
## with one argument: (value).
## Note: Unlike GD_.difference_by, this method mutates array.	
##
## Arguments
## 		array (Array): The array to modify.
## 		values (Array): The values to remove.
## 		[iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
## 		(Array): Returns array.
## Example
## 		var array = [{ 'x': 1 }, { 'x': 2 }, { 'x': 3 }, { 'x': 1 }]
## 		 
## 		GD_.pull_all_by(array, [{ 'x': 1 }, { 'x': 3 }], 'x')
## 		# => [{ 'x': 2 }]
static func pull_all_by(array:Array, values_to_remove = _EMPTY_ARRAY_, iteratee = GD_.identity):
    values_to_remove = GD_.cast_array(values_to_remove)
    
    var iter_func = iteratee(iteratee)
    values_to_remove = values_to_remove \
            if iter_func == GD_.identity \
            else GD_.map(values_to_remove,iter_func)
    
    var index = 0
    var max = array.size()
    while index < max:
        if iter_func.call(array[index], null) in values_to_remove:
            array.remove_at(index)
            max -= 1
        else:
            # we only move 1 up  when theres no re-index inovlved 
            # because items are shifted backward
            index += 1
                        
    return array
    
## This method is like GD_.pull_all except that it accepts comparator which 
## is invoked to compare elements of array to values. The comparator is 
## invoked with two arguments: (arrVal, othVal).
## Note: Unlike GD_.difference_with, this method mutates array.
##
## Arguments
## 		array (Array): The array to modify.
## 		values (Array): The values to remove.
## 		[comparator] (Function): The comparator invoked per element.
## Returns
## 		(Array): Returns array.
## Example
## 		var array = [{ 'x': 1, 'y': 2 }, { 'x': 3, 'y': 4 }, { 'x': 5, 'y': 6 }]
## 		 
## 		GD_.pull_all_with(array, [{ 'x': 3, 'y': 4 }], GD_.is_equal)
## 		print(array)
## 		# => [{ 'x': 1, 'y': 2 }, { 'x': 5, 'y': 6 }]
static func pull_all_with(array:Array, values_to_remove, comparator:Callable = GD_.is_equal):
    values_to_remove = GD_.cast_array(values_to_remove)
    
    var index = 0
    var max = array.size()
    while index < max:
        var should_remove = false
        
        for removable in values_to_remove:
            if comparator.call(array[index], removable):
                should_remove = true
                break
                
        if should_remove:
                array.remove_at(index)
                max -= 1
        else:
            # we only move 1 up  when theres no re-index inovlved 
            # because items are shifted backward
            index += 1
                        
    return array
    

## Removes elements from array corresponding to indexes and returns 
## an array of removed elements.
## 
## Note: Unlike GD_.at, this method mutates array.
## 
## Arguments
## 		array (Array): The array to modify.
## 		[indexes] (...(number|number[])): The indexes of elements to remove.
## Returns
## 		(Array): Returns the new array of removed elements.
## Example
## 		var array = ['a', 'b', 'c', 'd']
## 		var pulled = GD_.pull_at(array, [1, 3])
## 		 
## 		print(array)
## 		# => ['a', 'c']
## 		 
## 		print(pulled)
## 		# => ['b', 'd']
static func pull_at(array:Array, values_to_remove:Array):
    var array_size = array.size()
    var removed_array = []
    for i in range( values_to_remove.size() - 1, -1, -1):
        var index_to_remove = values_to_remove[i]
        if index_to_remove is int \
            and index_to_remove < array_size \
            and index_to_remove >= 0:
            removed_array.append(array.pop_at(index_to_remove))
    removed_array.reverse()
    return removed_array
    
## Removes all elements from array that predicate returns truthy for 
## and returns an array of the removed elements. The predicate is invoked 
## with two arguments: (value, index).
## Note: Unlike GD_.filter, this method mutates array. 
## Use GD_.pull to pull elements from an array by value.
## 
## 
## Arguments
## 		array (Array): The array to modify.
## 		[predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
## 		(Array): Returns the new array of removed elements.
## Example
## 		var array = [1, 2, 3, 4]
## 		var evens = GD_.remove(array, func(n, _i):
## 			return n % 2 == 0
## 		)
##  	
## 		print(array)
## 		# => [1, 3]
## 		 
## 		print(evens)
## 		# => [2, 4]
static func remove(array:Array, predicate = GD_.identity):
    var array_size = array.size()
    var removed_array = []
    var iter_func = iteratee(predicate)
    
    for i in range( array_size - 1, -1, -1):
        var item = array[i]
        if iter_func.call(item,i):
            removed_array.append(array.pop_at(i))
    removed_array.reverse()
    return removed_array
    
## Reverses array so that the first element becomes the last, the second element 
## becomes the second to last, and so on.
## Note: This is a wrapper on Godot's Array.reverse()
##
##
## Arguments
## 		array (Array): The array to modify.
## Returns
## 		(Array): Returns array.
## Example
## 		var array = [1, 2, 3]
## 		 
## 		GD_.reverse(array)
## 		# => [3, 2, 1]
## 		 
## 		print(array)
## 		# => [3, 2, 1]
static func reverse(array:Array):
    array.reverse()
    return array

## Creates a slice of array from start up to, but not including, end.
## 
## Note: This method is a wrapper for Godot's Array.slice
## 
## Arguments
## 		array (Array): The array to slice.
## 		[start=0] (number): The start position.
## 		[end=array.length] (number): The end position.
## Returns
## 		(Array): Returns the slice of array.
## Example
##		var array = [0,1,2,3,4]
##		var slice = GD_.slice(array,1,4)
##
##		print(slice)
##		# => [1,2,3]
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func slice(array:Array, start=0,end = array.size()): 
    return array.slice(start,end)
    

## Uses a binary search to determine the lowest index at which 
## value should be inserted into array in order to maintain its sort order.
## 
## 
## Arguments
## 		array (Array): The sorted array to inspect.
## 		value (*): The value to evaluate.
## Returns
## 		(number): Returns the index at which value should be inserted into array.
## Example
## 		GD_.sorted_index([30, 50], 40)
## 		# => 1
static func sorted_index(array:Array, value):
    if not(GD_.is_number(value)):
        gd_warn("GD_.sorted_index received a non-number value")
        return null
        
    return sorted_index_by(array,value)


## This method is like _.sortedIndex except that it accepts iteratee 
## which is invoked for value and each element of array to compute 
## their sort ranking. The iteratee is invoked 
## with two arguments: (value, _UNUSED_).
##
##
## Arguments
## 		array (Array): The sorted array to inspect.
## 		value (*): The value to evaluate.
## 		[iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
## 		(number): Returns the index at which value should be inserted into array.
## Example
## 		var objects = [{ 'x': 4 }, { 'x': 5 }]
## 		 
## 		GD_.sorted_index_by(objects, { 'x': 4 }, func(o): return o.x)
## 		# => 0
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.sorted_index_by(objects, { 'x': 4 }, 'x')
## 		# => 0 
static func sorted_index_by(array:Array, value, iteratee = GD_.identity): 
    var iter_func = iteratee(iteratee)
    var ceil = array.size()
    var mid = floor(ceil / 2)
    var floor = 0
    var actual_value = iter_func.call(value,null)
    for _i in range(0, ceil): # we use a for loop cause its faster
        if floor >= ceil:
            break
        
        if iter_func.call(array[mid],null) < actual_value:
            floor = mid + 1
        else:
            ceil = mid
        mid = floor((floor + ceil)/2)
    return floor


## This method is like _.indexOf except that it performs a binary 
## search on a sorted array.
## 
## 
## Arguments
## 		array (Array): The array to inspect.
## 		value (*): The value to search for.
## Returns
## 		(number): Returns the index of the matched value, else -1.
## Example
## 		GD _.sorted_index_of([4, 5, 5, 5, 6], 5)
## 		# => 1	
static func sorted_index_of(array:Array, value):
    if not(GD_.is_number(value)):
        gd_warn("GD_.sorted_index_of received a non-number value")
        return -1
        
    var ceil = array.size()
    var mid = floor(ceil / 2)
    var floor = 0
    var mid_val
    
    for _i in range(0, ceil): # we use a for loop cause its faster
        if floor >= ceil:
            break
        mid_val = array[mid]
            
        if mid_val == value:
            return mid
        elif mid_val < value:
            floor = mid + 1
        else:
            ceil = mid
        mid = floor((floor + ceil)/2)
    return -1
    

## This method is like GD_.sorted_index except that it returns the 
## highest index at which value should be inserted into array in 
## order to maintain its sort order.
## 
## 
## Arguments
## 		array (Array): The sorted array to inspect.
## 		value (*): The value to evaluate.
## Returns
## 		(number): Returns the index at which value should be inserted into array.
## Example
## 		GD_.sorted_last_index([4, 5, 5, 5, 6], 5)
## 		# => 4
static func sorted_last_index(array:Array, value):
    if not(GD_.is_number(value)):
        gd_warn("GD_.sorted_index received a non-number value")
        return null
        
    return sorted_last_index_by(array,value)
    

## This method is like GD_.sorted_last_index except that it accepts iteratee 
## which is invoked for value and each element of array to compute 
## their sort ranking. The iteratee is invoked 
## with two arguments: (value, _UNUSED_).
##
## 
## Arguments
## 		array (Array): The sorted array to inspect.
## 		value (*): The value to evaluate.
## 		[iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
## 		(number): Returns the index at which value should be inserted into array.
## Example
## 		var objects = [{ 'x': 4 }, { 'x': 5 }]
## 		GD_.sorted_last_index_by(objects, { 'x': 4 }, func(o,_u): return o.x)
## 		# => 1
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.sorted_last_index_by(objects, { 'x': 4 }, 'x')
## 		# => 1
static func sorted_last_index_by(array:Array, value, iteratee = GD_.identity): 
    var iter_func = iteratee(iteratee)
    var ceil = array.size()
    var mid = floor(ceil / 2)
    var floor = 0
    var actual_value = iter_func.call(value,null)
    for _i in range(0, ceil): # we use a for loop cause its faster
        if floor >= ceil:
            break
        
        if iter_func.call(array[mid],null) > actual_value:
            ceil = mid
        else:
            floor = mid + 1
        mid = floor((floor + ceil)/2)
    return floor


## This method is like _.lastIndexOf except that it performs a binary search on a sorted array.
##
## 
## Arguments
## 		array (Array): The array to inspect.
## 		value (*): The value to search for.
## Returns
## 		(number): Returns the index of the matched value, else -1.
## Example
## 		GD_.sorted_last_index_of([4, 5, 5, 5, 6], 5)
## 		# => 3
static func sorted_last_index_of(array:Array, value): 
    if not(GD_.is_number(value)):
        gd_warn("GD_.sorted_last_index_of received a non-number value")
        return -1
        
    var ceil = array.size()
    var mid = floor(ceil / 2)
    var floor = 0
    var mid_val
    var last_index = -1
    
    for _i in range(0, ceil): # we use a for loop cause its faster
        if floor >= ceil:
            break
        mid_val = array[mid]
            
        if mid_val == value:
            last_index = mid
            floor = mid + 1
        elif mid_val < value:
            floor = mid + 1
        else:
            ceil = mid
        mid = floor((floor + ceil)/2)
    return last_index
    
## This method is like GD_.uniq except that it's designed 
## and optimized for sorted arrays.
##
##
## Arguments
## 		array (Array): The array to inspect.
## Returns
## 		(Array): Returns the new duplicate free array.
## Example
## 		GD_.sorted_uniq([1, 1, 2])
## 		# => [1, 2]
static func sorted_uniq(array:Array):
    return sorted_uniq_by(array)
    

## This method is like GD_.uniq_by except that it's designed and 
## optimized for sorted arrays.
## 
## 
## Arguments
## 		array (Array): The array to inspect.
## 		[iteratee] (Function): The iteratee invoked per element.
## Returns
## 		(Array): Returns the new duplicate free array.
## Example
## 		GD_.sorted_uniq_by([1.1, 1.2, 2.3, 2.4], Math.floor)
## 		# => [1.1, 2.3]
static func sorted_uniq_by(array:Array, iteratee = GD_.identity): 
    var iter_func = iteratee(iteratee)
    var unique_array = []
    
    var prev_element = null

    for element in array:
        var curr_element = iter_func.call(element,null)
        if curr_element != prev_element:
            unique_array.append(element)
            prev_element = iter_func.call(element,null)

    return unique_array
    
## Gets all but the first element of array.
## 
## 
## Arguments
## 		array (Array): The array to query.
## Returns
## 		(Array): Returns the slice of array.
## Example
## 		GD_.tail([1, 2, 3])
## 		# => [2, 3]
static func tail(array:Array, _UNUSED_ = null): 
    return array.slice(1)
    

## Creates a slice of array with n elements taken from the beginning.
## 
##
## Arguments
## 		array (Array): The array to query.
## 		[n=1] (number): The number of elements to take.
## Returns
## 		(Array): Returns the slice of array.
## Example
## 		GD_.take([1, 2, 3])
## 		# => [1]
## 		 
## 		GD_.take([1, 2, 3], 2)
## 		# => [1, 2]
## 		 
## 		GD_.take([1, 2, 3], 5)
## 		# => [1, 2, 3]
## 		 
## 		GD_.take([1, 2, 3], 0)
## 		# => []
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func take(array:Array, n = null): 
    var size = array.size()
    if n == null:
        n = 1
    if size == 0 or not(GD_.is_number(n)) or n < 0:
        return []
    return array.slice(0, min(n,size))
    
    
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func take_right(array:Array, n = 1): not_implemented() 
static func take_right_while(array:Array, b=0, c=0): not_implemented()
static func take_while(array:Array, b=0, c=0): not_implemented()


## Creates an array of unique values, in order, from all given arrays using 
## == for equality comparisons.
## 
## 
## Arguments
## 		[arrays] (...Array): The arrays to inspect.
## Returns
## 		(Array): Returns the new array of combined values.
## Example
## 		GD_.union([2], [1, 2])
## 		# => [2, 1]
##
## 		GD_.union([1],[2],[3],[4],[5])
## 		# => [1,2,3,4,5]
## Notes
##		>> Variable Arguments
##			In js you can call an infinite amount of args using ellipses 
##			E.g. "GD_.union([1],[2],[3],[4],[5],[6],[7],["as many as you want"],[10])
##
##			But in GD_ you can call at most up to 10 args
##			E.g. "GD_.union([1],[2],[3],[4],[5],[6],[7],[8],[9],[10])
static func union(a:Array, b:Array, c=_UNDEF_,d=_UNDEF_,e=_UNDEF_,f=_UNDEF_,g=_UNDEF_,h=_UNDEF_,i=_UNDEF_,j=_UNDEF_):
    var array = a.duplicate()
    for arg in [b,c,d,e,f,g,h,i,j]:
        if arg is Array:
            array.append_array(arg)
    return GD_.uniq_by(array)
    
    
## This method is like GD_.union except that it accepts iteratee which 
## is invoked for each element of each arrays to generate the criterion 
## by which uniqueness is computed. Result values are chosen from 
## the first array in which the value occurs. 
## The iteratee is invoked with two arguments: (value , _UNUSED_).
## 
## 
## Arguments
## 		[arrays] (...Array): The arrays to inspect.
## 		[iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
## 		(Array): Returns the new array of combined values.
## Example
## 		GD_.union_by([2.1], [1.2, 2.3], GD_.floor)
## 		# => [2.1, 1.2]
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.union_by([{ 'x': 1 }], [{ 'x': 2 }, { 'x': 1 }], 'x')
## 		# => [{ 'x': 1 }, { 'x': 2 }]
static func union_by(array_a:Array, array_b:Array, iteratee = GD_.identity):
    var array_c = array_a.duplicate()
    array_c.append_array(array_b)
    return GD_.uniq_by(array_c, iteratee)


## This method is like GD_.union except that it accepts comparator 
## which is invoked to compare elements of arrays. Result values are chosen 
## from the first array in which the value occurs. The comparator is invoked 
## with two arguments: (arrVal, othVal).
## 
## 
## Arguments
## 		[arrays] (...Array): The arrays to inspect.
## 		[comparator] (Function): The comparator invoked per element.
## Returns
## 		(Array): Returns the new array of combined values.
## Example
## 		var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]
## 		var others = [{ 'x': 1, 'y': 1 }, { 'x': 1, 'y': 2 }]
##  
## 		GD_.union_with(objects, others, GD_.is_equal)
## 		# => [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }, { 'x': 1, 'y': 1 }]		
static func union_with(array_a:Array, array_b:Array, comparator:Callable):
    var array_c = array_a.duplicate()
    array_c.append_array(array_b)
    return GD_.uniq_with(array_c, comparator)

## Creates a duplicate-free version of an array, using == for equality 
## comparisons, in which only the first occurrence of each element is kept. 
## The order of result values is determined by the order 
## they occur in the array.
##
## 
## Arguments
## 		array (Array): The array to inspect.
## Returns
## 		(Array): Returns the new duplicate free array.
## Example
## 		GD_.uniq([2, 1, 2])
## 		# => [2, 1]
static func uniq(array:Array):
    return uniq_by(array)


## This method is like GD_.uniq except that it accepts iteratee which 
## is invoked for each element in array to generate the criterion by 
## which uniqueness is computed. The order of result values is determined 
## by the order they occur in the array. The iteratee is invoked 
## with two arguments : (value, _UNUSED_).
## 
## 
## Arguments
## 		array (Array): The array to inspect.
## 		[iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
## 		(Array): Returns the new duplicate free array.
## Example
## 		GD_.uniq_by([2.1, 1.2, 2.3], Math.floor)
## 		# => [2.1, 1.2]
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.uniq_by([{ 'x': 1 }, { 'x': 2 }, { 'x': 1 }], 'x')
## 		# => [{ 'x': 1 }, { 'x': 2 }]
static func uniq_by(array:Array, iteratee = GD_.identity):
    var cache = {}
    var new_array = []
    var iter_func = iteratee(iteratee)
    for _item in array:
        var item = iter_func.call(_item, null)
        if item in cache: continue
        
        cache[item] = true
        new_array.append(_item)
    return new_array


## This method is like GD_.uniq except that it accepts comparator 
## which is invoked to compare elements of array. The order of result values 
## is determined by the order they occur in the array. The 
## comparator is invoked with two arguments: (arrVal, othVal).
## 
## 
## Arguments
## 		array (Array): The array to inspect.
## 		[comparator] (Function): The comparator invoked per element.
## Returns
## 		(Array): Returns the new duplicate free array.
## Example
## 		var objects = [{'x':1,'y':2},{'x':2,'y':1},{'x':1,'y':2}]
## 		GD_.uniq_with(objects, GD_.is_equal)
## 		# => [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]	
static func uniq_with(array:Array, comparator:Callable):
    var new_array = []
    for old_item in array:
        var should_insert = true
        for new_item in new_array:
            if comparator.call(old_item,new_item):
                should_insert = false
                break
        if should_insert:
            new_array.append(old_item)
    return new_array
    
static func unzip(array:Array, b=0, c=0): not_implemented()
static func unzip_with(array:Array, b=0, c=0): not_implemented()

## Creates an array excluding all given values using == for equality comparisons.
## 
## Note: Unlike GD_.pull, this method returns a new array.
## 
## 
## Arguments
## 		array (Array): The array to inspect.
## 		[values] (...*): The values to exclude.
## Returns
## 		(Array): Returns the new array of filtered values.
## Example
## 		GD_.without([2, 1, 2, 3], 1, 2)
## 		# => [3]
static func without(array:Array, b=_UNDEF_,c=_UNDEF_,d=_UNDEF_,e=_UNDEF_,f=_UNDEF_,g=_UNDEF_,h=_UNDEF_,i=_UNDEF_,j=_UNDEF_):
    var without_list = []
    for arg in [b,c,d,e,f,g,h,i,j]:
        if arg is UNDEFINED: continue
        without_list.append(arg)
        
    var new_array = []
    var should_add
    for tmp in array:
        should_add = true
        for to_remove in without_list:
            if is_same(tmp, to_remove):
                should_add = false
                break
                
        if should_add:
            new_array.append(tmp)
        
    return new_array
        
    
static func xor(array:Array, b=0, c=0): not_implemented()
static func xor_by(array:Array, b=0, c=0): not_implemented()
static func xor_with(array:Array, b=0, c=0): not_implemented()


## Creates an array of grouped elements, the first of which contains the first elements of the 
## given arrays, the second of which contains the second elements of the given arrays, and so on.
## 
## 
## Arguments
##		[arrays] (...Array): The arrays to process.
## Returns
## 		(Array): Returns the new array of grouped elements.
## Example
## 		GD_.zip(['a', 'b'], [1, 2], [true, false])
## 		# => [['a', 1, true], ['b', 2, false]]
## Notes
##		>> Variable Arguments
##			In js you can call an infinite amount of args using ellipses 
##			E.g. _.zip([1], [2], [3],[4],  ... , [100], [101])
##
##			But in GD_ you can call at most up to 10 args
##			E.g. GD_.zip([1], [2], [3], ... , [10])
static func zip(a:Array, b=_UNDEF_,c=_UNDEF_,d=_UNDEF_,e=_UNDEF_,f=_UNDEF_,g=_UNDEF_,h=_UNDEF_,i=_UNDEF_,j=_UNDEF_): 
    return GD_.zip_with(a,b,c,d,e,f,g,h,i,j)


## This method is like _.fromPairs except that it accepts two arrays, one of property identifiers and one of corresponding values.
## 
## 
## Arguments
## 		[props=[]] (Array): The property identifiers.
## 		[values=[]] (Array): The property values.
## Returns
## 		(Object): Returns the new object.
## Example
## 		GD_.zip_object(['a', 'b'], [1, 2])
## 		# => { 'a': 1, 'b': 2 }
## Notes
##		>> Numbers as keys
##			In js you can call an infinite amount of args using ellipses 
##			E.g. _.zip([1], [2], [3],[4],  ... , [100], [101])
##
##			But in GD_ you can call at most up to 10 args
##			E.g. GD_.zip([1], [2], [3], ... , [10])
static func zip_object(keys:Array, values:Array):
    var dict = {}
    for i in range(0, keys.size()):
        dict[keys[i]] = __INTERNAL__.get_index(values,i)
    return dict
    
## This method is like _.zipObject except that it supports property paths.
## 
## 
## Arguments
## 		[props=[]] (Array): The property identifiers.
## 		[values=[]] (Array): The property values.
## Returns
## 		(Object): Returns the new object.
## Example
##		GD_.zip_object_deep(['a:b[0]:c', 'a:b[1]:d'], [1, 2])
##		# => { 'a': { 'b': {0:{'c':1},1:{'d':2}} } }
## Notes
##		>> Regarding integer keys
##			In js ["0", -0, 0] are "the same keys" when applied to an object
##			e.g. declaring {"0":"hello",0:"world"} in JS results in  {0:"world"}
##			But in gdscript ["0"] is a different key from [-0,0]
##			e.g. declaring {"0":"hello",0:"world"} in GODOT in {"0":"hello",0:"world"} 
## 		
##			Meaning in js
##			_.zipObjectDeep( ["0"], ["foo"]) == _.zipObjectDeep( [-0],  ["foo"]) == _.zipObjectDeep( [0], ["foo"])
##			And in godot
##			_.zip_object_deep( ["0"], ["foo"]) != _.zip_object_deep( [-0],  ["foo"]) == _.zip_object_deep( [0], ["foo"])
##
##			You can specify if you want a numeric key to act as a string by wrapping
##			it in a quoate (e.g.  in th_.zip_object_deep( ["0"], ["foo"]) )
static func zip_object_deep(keys:Array, values:Array):
    var dict = {}
    for i in range(0, keys.size()):
        var key = __INTERNAL__.string_to_path(keys[i])
        var value = __INTERNAL__.get_index(values,i)
        __INTERNAL__.set_dict_deep(dict, key, value)
    return dict

## This method is like GD_.zip except that it accepts iteratee to 
## specify how grouped values should be combined. The iteratee is 
## invoked with the elements of each group: (...group).
## 
## 
## Arguments
## 		[arrays] (...Array): The arrays to process.
## 		[iteratee=GD_.identity] (Function): The function to combine grouped values.
## Returns
## 		(Array): Returns the new array of grouped elements.
## Example
##		var iteratee = func(a,b,c): return a + b + c
## 		GD_.zip_with([1, 2], [10, 20], [100, 200], iteratee)
## 		# => [111, 222]
static func zip_with(a:Array, b=_UNDEF_,c=_UNDEF_,d=_UNDEF_,e=_UNDEF_,f=_UNDEF_,g=_UNDEF_,h=_UNDEF_,i=_UNDEF_,j=_UNDEF_): 
    var args = __INTERNAL__.to_clean_args(a,b,c,d,e,f,g,h,i,j)
    var has_callable_arg = args[-1] is Callable
    var iter_func = iteratee(args.pop_back()) if has_callable_arg else __INTERNAL__.to_clean_args
    
    var cursor = -1
    var result = []
    for array_arg in args:
        var size = array_arg.size()
        if cursor == size -1 : continue
        
        for index in range(max(cursor,0), array_arg.size()):
            cursor = index
            var arg_set = args.map(func (tmp): return tmp[cursor] if cursor < tmp.size() else null  )
            var tmp = iter_func.callv(arg_set)
            result.append(tmp)
        cursor += 1
    return result
            
    
"""
CATEGORY: Collections
"""

## Creates a dictionary composed of keys generated from the results of 
## running each element of collection thru iteratee. The corresponding value 
## of each key is the number of times the key was returned by iteratee. 
## The iteratee is invoked with two arguments: (value, _UNUSED_).
##
##
## Arguments
## 		collection (Array|Object): The collection to iterate over.
## 		[iteratee=GD_.identity] (Function): The iteratee to transform keys.
## Returns
## 		(Object): Returns the composed aggregate object.
## Example
## 		GD_.count_by([6.1, 4.2, 6.3], GD_.floor)
## 		# => { '4': 1, '6': 2 }
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.count_by(['one', 'two', 'three'], 'length')
## 		# => { '3': 2, '5': 1 }
static func count_by(collection, iteratee = null):
    if not(GD_._is_collection(collection)):
        gd_warn("GD_.count_by received a non-collection type value")
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
static func each(collection, iteratee): 
    gd_warn("GD_.each is an alias, prefer GD_.for_each to avoid overhead")
    return for_each(collection, iteratee)


## Iterates over elements of collection and invokes iteratee for each element. 
## The iteratee is invoked with two arguments: (value, index|key). 
## Iteratee functions may exit iteration early by explicitly returning false.
##
##
## Aliases
## 		GD_.each
## Arguments
## 		collection (Array|Object): The collection to iterate over.
## 		[iteratee=GD_.identity] (Function): The function invoked per iteration.
## Returns
## 		(*): Returns collection.
## Example
## 		GD_.for_each([1, 2], func (value,_index): print(value))
## 		# => Logs `1` then `2`.
## 		 
## 		GD_.for_each({ 'a': 1, 'b': 2 }, func (_value, key): print(key))
## 		# => Logs 'a' then 'b' (iteration order is not guaranteed).
static func for_each(collection, iteratee): 
    if not(GD_._is_collection(collection)):
        gd_warn("GD_.for_each received a non-collection type value")
        return null
        
    var iter_func = iteratee(iteratee)
    for key in keyed_iterable(collection):
        var result = iter_func.call(collection[key],key)
        # short circuit
        if is_same(result,false): 
            return

static func each_right(a=0, b=0, c=0): not_implemented()


## Checks if predicate returns truthy for all elements of collection. 
## Iteration is stopped once predicate returns falsey. The predicate is invoked with 
## two arguments: (value, index|key).
## 
## 
## Arguments
## 		collection (Array|Object): The collection to iterate over.
## 		[predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
## 		(boolean): Returns true if all elements pass the predicate check, else false.
## Example
## 		GD_.every([true, 1, null, 'yes'])
## 		# => false
## 		 
## 		var users = [
## 		  { 'user': 'barney', 'age': 36, 'active': false },
## 		  { 'user': 'fred',   'age': 40, 'active': false }
## 		]
## 		 
## 		// The `GD_.matches` iteratee shorthand.
## 		GD_.every(users, { 'user': 'barney', 'active': false })
## 		# => false
## 		 
## 		// The `GD_.matchesProperty` iteratee shorthand.
## 		GD_.every(users, ['active', false])
## 		# => true
## 		 
## 		// The `GD_.property` iteratee shorthand.
## 		GD_.every(users, 'active')
## 		# => false
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func every(collection, predicate = GD_.identity):  
    var predicate_fn = iteratee(predicate)
    for key in keyed_iterable(collection):
        var thing = collection[key]
        if not predicate_fn.call(thing, key):
            return false
    return true

## Iterates over elements of collection, returning an array of all elements predicate returns truthy for. 
## The predicate is invoked with two arguments (value, index|key).
##
## Arguments
## 		collection (Array|Object): The collection to iterate over.
## 		[predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
## 		(Array): Returns the new filtered array.
## Example
## 		var users = [
## 		  { 'user': 'barney', 'age': 36, 'active': true },
## 		  { 'user': 'fred',   'age': 40, 'active': false }
## 		]
## 		 
## 		GD_.filter(users, func(o,_index): return !o.active)
## 		# => objects for ['fred']
## 		 
## 		# The `GD_.matches` iteratee shorthand.
## 		GD_.filter(users, { 'age': 36, 'active': true })
## 		# => objects for ['barney']
## 		 
## 		# The `GD_.matches_property` iteratee shorthand.
## 		GD_.filter(users, ['active', false])
## 		# => objects for ['fred']
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.filter(users, 'active')
## 		# => objects for ['barney']
static func filter(collection, iteratee = null):
    if not(GD_._is_collection(collection)):
        gd_warn("GD_.filter received a non-collection type value")
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
## 
## Arguments
## 		collection (Array|Object): The collection to inspect.
## 		[predicate=GD_.identity] (Function): The function invoked per iteration.
## 		[fromIndex=0] (number): The index to search from.
## Returns
## 		(*): Returns the matched element, else null.
## Example
## 		var users = [
## 		  { 'user': 'barney',  'age': 36, 'active': true },
## 		  { 'user': 'fred',    'age': 40, 'active': false },
## 		  { 'user': 'pebbles', 'age': 1,  'active': true }
## 		]
##  
## 		GD_.find(users, func(o,_index): return o.age < 40)
## 		# => object for 'barney'
## 		 
## 		# The `GD_.matches` iteratee shorthand.
## 		GD_.find(users, { 'age': 1, 'active': true })
## 		# => object for 'pebbles'
## 		 
## 		# The `GD_.matches_property` iteratee shorthand.
## 		GD_.find(users, ['active', false])
## 		# => object for 'fred'
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.find(users, 'active')
## 		# => object for 'barney'
static func find(collection, iteratee = null, from_index = 0):
    if not(GD_._is_collection(collection)):
        gd_warn("GD_.find received a non-collection type value")
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
## The iteratee is invoked with two arguments: (value, _UNUSED_).
##
##
## Arguments
## 		collection (Array|Object): The collection to iterate over.
## 		[iteratee=GD_.identity] (Function): The iteratee to transform keys.
## Returns
## 		(Object): Returns the composed aggregate object.
## Example
## 		GD_.group_by([6.1, 4.2, 6.3], GD_.floor)
## 		# => { '4': [4.2], '6': [6.1, 6.3] }
## 		 
## 		# The `_.property` iteratee shorthand.
## 		GD_.group_by(['one', 'two', 'three'], 'length')
## 		# => { '3': ['one', 'two'], '5': ['three'] }
static func group_by(collection, iteratee = GD_.identity):
    if not(GD_._is_collection(collection)):
        gd_warn("GD_.group_by received a non-collection type value")
        return null
        
    var iter_func = iteratee(iteratee)
    var counters = {}
    for item in collection:
        var key = str(iter_func.call(item,null))
        if not(counters.has(key)):
            counters[key] = []
        counters[key].append(item)
    return counters
    
## Checks if value is in collection. If collection is a string, it's checked for 
## a substring of value, otherwise == is used for equality comparisons. 
## If fromIndex is negative, it's used as the offset from the end of collection.
## 
## 
## Arguments
## 		collection (Array|Object|string): The collection to inspect.
## 		value (*): The value to search for.
## 		[fromIndex=0] (number): The index to search from.
## 	Returns
## 		(boolean): Returns true if value is found, else false.
## Example
## 		GD_.includes([1, 2, 3], 1)
## 		# => true
## 		 
## 		GD_.includes([1, 2, 3], 1, 2)
## 		# => false
## 		 
## 		GD_.includes({ 'a': 1, 'b': 2 }, 1)
## 		# => true
## 		 
## 		GD_.includes('abcd', 'bc')
## 		# => true
static func includes(collection, thing, from_index :=0):
    if GD_._is_collection(collection):
        for key in keyed_iterable(collection,from_index):
            if is_equal(collection[key], thing): 
                return true
        return false
        
    gd_warn("GD_.includes received a non-collection type value")
    return false
static func invoke_map(a=0, b=0, c=0): not_implemented()
static func key_by(a=0, b=0, c=0): not_implemented()

## Creates an array of values by running each element in collection thru 
## iteratee. The iteratee is invoked with two arguments: (value, index|key).
## The iteratee is invoked with two arguments: (value, index).
##
## Arguments
## 		collection (Array|Object): The collection to iterate over.
## 		[iteratee=GD_.identity] (Function): The function invoked per iteration.
## Returns
## 		(Array): Returns the new mapped array.
## Example
## 		func square(n, _index): return n * n
##  
## 		GD_.map([4, 8], square)
## 		# => [16, 64]
## 		 
## 		GD_.map({ 'a': 4, 'b': 8 }, square)
## 		# => [16, 64] (iteration order is not guaranteed)
## 		 
## 		var users = [
## 		  { 'user': 'barney' },
## 		  { 'user': 'fred' }
## 		]
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.map(users, 'user')
## 		# => ['barney', 'fred']
static func map(collection, iteratee = GD_.identity):
    if not(GD_._is_collection(collection)):
        gd_warn("GD_.map received a non-collection type value")
        return null
        
    var iter_func = GD_.iteratee(iteratee)
        
    var new_collection = []
    for key in keyed_iterable(collection):
        var item = collection[key]
        new_collection.append(iter_func.call(item,key))
    return new_collection
    
    
static func order_by(a=0, b=0, c=0): not_implemented()
static func partition(a=0, b=0, c=0): not_implemented()

## Reduces collection to a value which is the accumulated result of running 
## each element in collection thru iteratee, where each successive invocation 
## is supplied the return value of the previous. If accumulator is not given, 
## the first element of collection is used as the initial value. 
## The iteratee two arguments: (accumulator, {"key":key,"value":value}).
## 
## Arguments
## 		collection (Array|Object): The collection to iterate over.
## 		[iteratee=GD_.identity] (Function): The function invoked per iteration.
## 		[accumulator] (*): The initial value.
## Returns
## 		(*): Returns the accumulated value.
## Example
## 		var sum = func (accum, kv): return accum + kv.value
## 		GD_.reduce([1, 2], sum, 0)
## 		# => 3
##  	
##		var cb = func (result, kv):
## 		  (result[kv.value] || (result[kv.value] = [])).push(kv.key)
## 		  return result
## 		
## 		GD_.reduce({ 'a': 1, 'b': 2, 'c': 1 }, cb, {})
## 		# => { '1': ['a', 'c'], '2': ['b'] } (iteration order is not guaranteed)
## Notes
##		>> Callable Signature
##			In GD_ we try to standardize callbacks into having 2 arguments
##			So they can be chained together. Thats why we pass a dictionary down
## 			instead
static func reduce(collection, iteratee=GD_.identity, accumulator = null):
    if not GD_._is_collection(collection):
        return null
    
    var iter_func = iteratee(iteratee)
    
    var iterable = keyed_iterable(collection)
    var starting_index = 0
    if accumulator == null:
        starting_index = 1
        var key = iterable[0]
        accumulator = collection[key]
    var kv_tmp =  {"key":null,"value":null}
    for key_index in range(starting_index, GD_.size(iterable)):
        kv_tmp.key = iterable[key_index]
        kv_tmp.value = collection[kv_tmp.key]
        accumulator = iter_func.call(accumulator, kv_tmp)
    
    return accumulator
        

## This method is like GD_.reduce except that it iterates over elements 
## of collection from right to left.
## 
## 
## Arguments
## 		collection (Array|Object): The collection to iterate over.
## 		[iteratee=GD_.identity] (Function): The function invoked per iteration.
## 		[accumulator] (*): The initial value.
## Returns
## 		(*): Returns the accumulated value.
## Example
## 		var array = [[0, 1], [2, 3], [4, 5]]
## 		 
##		var concat = func (flattened, kv): flattened.append_array(kv.value)
## 		GD_.reduce_right(array, concat, [])
## 		# => [4, 5, 2, 3, 0, 1]
static func reduce_right(collection, iteratee=GD_.identity, accumulator = null):
    if not GD_._is_collection(collection):
        return null
        
    var iter_func = iteratee(iteratee)
    var iterable = keyed_iterable(collection)
    
    for key_index in range(GD_.size(iterable) - 1, -1, -1):
        var key = iterable[key_index]
        var value = collection[key]
    
    var starting_index = GD_.size(iterable) - 1
    
    if accumulator == null:
        var key = iterable[ starting_index ]
        starting_index = starting_index - 1
        accumulator = collection[key]
        
    for key_index in range(starting_index, -1, -1):
        var key = iterable[key_index]
        var value = collection[key]
        accumulator = iter_func.call(accumulator, {"key":key,"value":value})
    
    return accumulator

## The opposite of GD_.filter this method returns the elements of collection that 
## predicate does not return truthy for.  The iteratee is invoked 
## with two args (value, index)
## 
## Arguments
## 		collection (Array|Object): The collection to iterate over.
## 		[predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
## 		(Array): Returns the new filtered array.
## Example
## 		var users = [
## 		  { 'user': 'barney', 'age': 36, 'active': false },
## 		  { 'user': 'fred',   'age': 40, 'active': true }
## 		]
##		var not_active = func (o, i): 
##			return !o.active
##
## 		GD_.reject(users, function(o) { return !o.active })
## 		# => objects for ['fred']
## 		 
## 		# The `GD_.matches` iteratee shorthand.
## 		GD_.reject(users, { 'age': 40, 'active': true })
## 		# => objects for ['barney']
## 		 
## 		# The `GD_.matchesProperty` iteratee shorthand.
## 		GD_.reject(users, ['active', false])
## 		# => objects for ['fred']
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.reject(users, 'active')
## 		# => objects for ['barney']
static func reject(collection, callable = GD_.identity): 
    var ary = []
    var iter_func = iteratee(callable)
    for key in keyed_iterable(collection):
        var item = collection[key]
        if not(iter_func.call(item,item)):
            ary.append(item)
    return ary
    
static func sample(a=0, b=0, c=0): not_implemented()
static func sample_size(a=0, b=0, c=0): not_implemented() 
# @TODO guarded method by map, every, filter, mapValues, reject, some

static func shuffle(collection):
    if collection is Array:
        # Use built in function
        var dup = collection.duplicate()
        dup.shuffle()
        return dup
    elif GD_.is_custom_iterator(collection):
        collection = GD_.to_array(collection)
    
    # Fallback to manual implementation
    var keys = keyed_iterable(collection)
    var new_array = []
    var i = GD_.size(keys)
    var array = []
    
    while i != 0:
        var random_index = randi() % i
        i -= 1
        new_array.append(collection[keys[random_index]])
        keys.erase(keys[random_index])
        
    return new_array

## Gets the size of collection by returning its length for array-like values 
## or the number of own enumerable string keyed properties for objects.
## 
##
## Arguments
## 		collection (Array|Object|string): The collection to inspect.
## Returns
##		(number): Returns the collection size.
## Example
## 		GD_.size([1, 2, 3])
## 		# => 3
##
## 		GD_.size({ 'a': 1, 'b': 2 })
## 		# => 2
##
## 		GD_.size('pebbles')
## 		# => 7
## Notes
##		>> Collections in JS
##			In js, anything can turn to a collection as long as it has the field
##			length. In GD_, for as long as it implements length() or size() it
##			size will use that and return it
static func size(thing): 
    if GD_.is_array(thing) or thing is Dictionary:
        return thing.size()
    elif GD_.is_string(thing):
        return thing.length()
    elif thing is Object:
        if thing.has_method('length'):
            return thing.length()
        elif thing.has_method('size'):
            return thing.size()
        elif GD_.is_custom_iterator(thing):
            gd_warn("GD_.size received a custom iterator that doesnt implement size or length. This will be expensive to calculate")
            var ctr = 0
            for i in thing: 
                ctr += 1
            return ctr
    gd_warn("GD_.size received a non-collection type value")
    return 0

## Checks if predicate returns truthy for any element of collection. 
## Iteration is stopped once predicate returns truthy. 
## The predicate is invoked with two arguments: (value, index|key).
##
## Arguments
## 		collection (Array|Dictionary|String): The collection to iterate over.
## 		[predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
## 		(boolean): Returns true if any element passes the predicate check, else false.
## Example
## 		GD_.some([null, 0, 'yes', false], Boolean)
## 		# => true
## 		 
## 		var users = [
## 		  { 'user': 'barney', 'active': true },
## 		  { 'user': 'fred',   'active': false }
## 		]
## 		 
## 		# The `GD_.matches` iteratee shorthand.
## 		GD_.some(users, { 'user': 'barney', 'active': false })
## 		# => false
## 		 
## 		# The `GD_.matches_property` iteratee shorthand.
## 		GD_.some(users, ['active', false])
## 		# => true
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.some(users, 'active')
## 		# => true
## Notes:
##		>> @TODO guarded method by map, every, filter, mapValues, reject, some
static func some(collection, iteratee = null): 
    return __INTERNAL__.base_some(collection, iteratee)
    
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func sort_by(a=0, b=0, c=0): not_implemented() 

"""
CATEGORY: Date
"""
static func now(a=0, b=0, c=0): not_implemented()
"""
CATEGORY: Function
"""
## The opposite of GD_.before; this method creates a function that 
## invokes func once it's called n or more times.
## 
## Arguments
## 		n (number): The number of calls before func is invoked.
## 		func (Function): The function to restrict.
## Returns
## 		(Function): Returns the new restricted function.
## Example
##		var fn = func (): print("hello world")
## 		var restricted = GD_.after(2, fn)
## 		
##		for i in 5: fn.call()
##		# => Only prints "hello world" 3 times (starting on the 3rd call)
## Notes
##		>> JS Variations
##			Theres a weird edge case where if you supply 1 as the number
##			Then it doesnt execute atleast once. That behavior has not
##			been replicated.
##		>> Memory Gotcha
##			To implement this, GD_ keeps an internal record of how many times
##			The passed in function has been called. That tracker cannot be
##			garbage collected so use this function sparingly.
static func after(after_count, callable:Callable):
    return __INTERNAL__.base_after(after_count, callable)
    
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func ary(a=0, b=0, c=0): not_implemented() 

## Creates a function that invokes func, with the this binding and 
## arguments of the created function, while it's called less than n times. 
## Subsequent calls to the created function return the result of 
## the last func invocation.
##
## Arguments
## 		n (number): The number of calls at which func is no longer invoked.
## 		func (Callable): The function to restrict.
## Returns
## 		(Function): Returns the new restricted function.
## Example
##		var fn = func (): print("hello world")
## 		var restricted = GD_.before(2, fn)
## 		
##		for i in 5: fn.call()
##		# => Only prints "hello world" twice
## Notes
##		>> JS Variations
##			Theres a weird edge case where if you supply 1 as the number
##			Then it doesnt execute atleast once. That behavior has not
##			been replicated.
##		>> Memory Gotcha
##			To implement this, GD_ keeps an internal record of how many times
##			The passed in function has been called. That tracker cannot be
##			garbage collected so use this function sparingly.
static func before(up_to_count, callable:Callable): 
    return __INTERNAL__.base_before(up_to_count, callable)
    
    
static func bind(a=0, b=0, c=0): not_implemented()
static func bind_key(a=0, b=0, c=0): not_implemented()

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func curry(a=0, b=0, c=0): not_implemented() 
# @TODO guarded method by map, every, filter, mapValues, reject, some
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
CATEGORY: Lang
"""


## Casts value as an array if it's not one.
##
## Arguments
## 		value (*): The value to inspect.
## Returns
## 		(Array): Returns the cast array.
## Example
## 		GD_.castArray(1)
## 		# => [1]
## 		 
## 		GD_.castArray({ 'a': 1 })
## 		# => [{ 'a': 1 }]
## 		 
## 		GD_.castArray('abc')
## 		# => ['abc']
## 		 
## 		GD_.castArray(null)
## 		# => [null]
## 		 
## 		GD_.castArray(null)
## 		# => [null]
## 		 
## 		GD_.castArray()
## 		# => []
## 		 
## 		var array = [1, 2, 3]
## 		print(GD_.castArray(array) == array)
## 		# => true
static func cast_array(v = _UNDEF_):
    if is_same(v, _UNDEF_):
        return []
    else:
        return v if v is Array else [v]
    
## Creates a shallow clone for most values.
## Creates a good-enough clone for values that cannot be cloned 
## by conventional means.
## 
## Arguments
## 		value (*): The value to clone.
## Returns
## 		(*): Returns the cloned value.
## Example
## 		var objects = [{ 'a': 1 }, { 'b': 2 }]
##  
## 		var shallow = GD_.clone(objects)
## 		console.log(shallow[0] === objects[0])
## 		# true
## Notes
##		>> JS Comparison
##			In javascript, everything is an object which makes cloning relatively
##			simple, but in GDScript, some types are distinct. This makes cloning
##			a bit harder so GD_ instead is more loose on "how" a thing is cloned
##			preferring to rebuild a replica of an uncloneable class instead of
##			what would have been a "shallow" clone in js
static func clone(thing):
    if GD_.is_array(thing) \
        or thing is Dictionary \
        or GD_.has_method_safe(thing,'duplicate'):
        return thing.duplicate()
    elif GD_.is_immutable(thing):
        # object is already done by copy, just return the thing again
        return thing
    elif thing is Object:
        if thing is RegEx:
            var tmp = RegEx.new()
            tmp.compile(thing.get_pattern())
            return tmp
    gd_warn("Untested type being cloned - for safety reasons we will return a null instead. If you feel like this should be a cloneable type please open an issue")
    return null
        
    
    
static func clone_deep(a=0, b=0, c=0): not_implemented()
static func clone_deep_with(a=0, b=0, c=0): not_implemented()
static func clone_with(a=0, b=0, c=0): not_implemented()
static func conforms_to(a=0, b=0, c=0): not_implemented()


## Basically a lambda wrapper for `==`. Because of the way dicts and
## arrays implement the "==" operators, it results in a deep comparison.
## So GD_.is_equal, GD_.eq, and ==, have all the same results
static func eq(a,b):
    return a == b


## Checks if value is greater than other.
##
## Arguments
## 		value (*): The value to compare.
## 		other (*): The other value to compare.
## Returns
## 		(boolean): Returns true if value is greater than other, else false.
## Example
## 		GD_.gt(3, 1)
## 		# => true
## 		GD 
## 		GD_.gt(3, 3)
## 		# => false
## 		GD 
## 		GD_.gt(1, 3)
## 		# => false
static func gt(a, b):
    return a > b
    
    
## Checks if value is greater than other.
##
##
## Arguments
## 		value (*): The value to compare.
## 		other (*): The other value to compare.
## Returns
## 		(boolean): Returns true if value is greater than or equal to other, else false.
## Example
## 		GD_.gte(3, 1)
## 		# => true
## 		 
## 		GD_.gte(3, 3)
## 		# => true
## 		 
## 		GD_.gte(1, 3)
## 		# => false
static func gte(a,b):
    return a >= b
    
## Same as has_method but checks the type first
static func has_method_safe(o,method:String):
    return o is Object and o.has_method(method)
    
    
static func is_arguments(a=0, b=0, c=0): not_implemented()


## Checks if value is an Array or one of the PackedArray variants
##
## Arguments
## 		value (*): The value to check.
## Returns
## 		(boolean): Returns true if value is an array or packed array
## Example
## 		GD_.is_array([1,2,3,4])
## 		# => true
##
## 		GD_.is_array(PackedByteArray([1,2,3,4]))
## 		# => true
## 		 
## 		GD_.is_array({1:2,3:4})
## 		# => false
## 		 
## 		GD_.is_array('abc')
## 		# => false
## 		 
## 		GD_.is_array(GD_.noop)
## 		# => false
## Notes
##		>> JS Comparison
##			Theres are no "Packed" arrays in JS
static func is_array(thing):
    var type = typeof(thing)
    return type <= TYPE_PACKED_COLOR_ARRAY and type >= TYPE_ARRAY
    
static func is_array_buffer(a=0, b=0, c=0): not_implemented()

## Checks if value implements a custom iterator.
## See https://docs.godotengine.org/en/latest/tutorials/scripting/gdscript/gdscript_advanced.html#custom-iterators
##
## Arguments
## 		value (*): The value to check.
## Returns
## 		(boolean): Returns true if value is a custom iterator
## Example
##		class CustomIterator:  # custom iterator implementation
##
## 		GD_.is_array_like(CustomIterator.new())
## 		# => true
##
## 		GD_.is_array([1,2,3,4])
## 		# => true
## Lodash Equivalent 
##		None
static func is_custom_iterator(tmp):
    return tmp is Object and tmp.has_method('_iter_next')

## Checks if value is array-like. A value is considered 
## array-like if it can be used in a for loop.
## 
## 
## Arguments
##		value (*): The value to check.
## Returns
## 		(boolean): Returns true if value is array-like, else false.
## Example
## 		GD_.is_array_like([1, 2, 3])
## 		# => true
## 		 
## 		GD_.is_array_like('abc')
## 		# => true
##
##		class CustomIterator:  # custom iterator implementation
## 		GD_.is_array_like(CustomIterator.new()
## 		# => true
##
## 		GD_.is_array_like(GD_.noop)
##		# => false
static func is_array_like(tmp): 
    return GD_.is_array(tmp) \
        or GD_.is_string(tmp) \
        or GD_.is_custom_iterator(tmp)
        
static func is_array_like_object(a=0, b=0, c=0): not_implemented()


static func is_boolean(a=0, b=0, c=0): not_implemented()
static func is_buffer(a=0, b=0, c=0): not_implemented()
static func is_date(a=0, b=0, c=0): not_implemented()
static func is_element(a=0, b=0, c=0): not_implemented()
static func is_empty(a=0, b=0, c=0): not_implemented()

## Basically a lambda wrapper for `==`. Because of the way dicts and
## arrays implement the "==" operators, it results in a deep comparison.
## So GD_.is_equal, GD_.eq, and ==, have all the same results
static func is_equal(left,right): 
    return typeof(left) == typeof(right) and left == right
    
    
    
static func is_equal_with(a=0, b=0, c=0): not_implemented()
static func is_error(a=0, b=0, c=0): not_implemented()
#static func is_finite(a=0, b=0, c=0): not_implemented()
static func is_function(a=0, b=0, c=0): not_implemented()

## Checks if the type is a mutable or an immutable type. A type is classified
## as immutable if a completely identical value of a certain type passes the
## is_same test.
##
## Arguments
##		value (*): The value to check.
## Returns
## 		(boolean): Returns true if value is immutable
## Example
##		GD_.is_immutable("foobar")
##		# => true
##
##		GD_.is_immutable([1,2,3,4])
##		# => false
## Lodash Equivalent 
##		None
static func is_immutable(thing):
    var is_mutable_type = GD_.is_array(thing) \
            or thing is Object \
            or thing is Dictionary
    return not(is_mutable_type)
static func is_integer(a=0, b=0, c=0): not_implemented()
static func is_length(a=0, b=0, c=0): not_implemented()
static func is_map(a=0, b=0, c=0): not_implemented()
static func is_match(a=0, b=0, c=0): not_implemented()
static func is_match_with(a=0, b=0, c=0): not_implemented()
#static func is_nan(a=0, b=0, c=0): not_implemented()
static func is_native(a=0, b=0, c=0): not_implemented()
static func is_nil(a=0, b=0, c=0): not_implemented()
static func is_null(a=0, b=0, c=0): not_implemented()

## Checks if value is classified as a Number primitive 
## Note: To exclude Infinity, -Infinity, and NaN, which are classified 
## as numbers, use the _.isFinite method.
## 
## 
## Arguments
## 		value (*): The value to check.
## Returns
## 		(boolean): Returns true if value is a number, else false.
## Example
## 		GD_.is_number(3)
## 		# => true
## 		 
## 		GD_.is_number(Number.MIN_VALUE)
## 		# => true
## 		 
## 		GD_.is_number(Infinity)
## 		# => true
## 		 
## 		GD_.is_number('3')
## 		# => false
static func is_number(a = null, _UNUSED_=null):
    return a is int or a is float
    
static func is_object(a=0, b=0, c=0): not_implemented()
static func is_object_like(a=0, b=0, c=0): not_implemented()

static func is_plain_object(a=0, b=0, c=0): not_implemented()

static func is_reg_exp(a=0, b=0, c=0): not_implemented()
static func is_safe_integer(a=0, b=0, c=0): not_implemented()
static func is_set(a=0, b=0, c=0): not_implemented()

## Checks if value is classified as a String or a StringName
##
## Arguments
## 		value (*): The value to check.
## Returns
## 		(boolean): Returns true if value is a string, else false.
## Example
## 		GD_.is_string('abc')
## 		# => true
## 		GD_.is_string(&'abc')
## 		# => true
## 		GD_.is_string(1)
## 		# => false
static func is_string(thing):
    return thing is String or thing is StringName
    
static func is_symbol(a=0, b=0, c=0): not_implemented()
static func is_typed_array(a=0, b=0, c=0): not_implemented()
static func is_undefined(a=0, b=0, c=0): not_implemented()
static func is_weak_map(a=0, b=0, c=0): not_implemented()
static func is_weak_set(a=0, b=0, c=0): not_implemented()

## Checks if value is less than other.
## Arguments
## 		value (*): The value to compare.
## 		other (*): The other value to compare.
## Returns
## 		(boolean): Returns true if value is less than other, else false.
## Example
## 		GD_.lt(1, 3)
## 		# => true
## 		 
## 		GD_.lt(3, 3)
## 		# => false
## 		 
## 		GD_.lt(3, 1)
## 		# => false
static func lt(a, b):
    return a < b
static func lte(a=0, b=0, c=0):
    return a <= b
    
## Converts value to an array.
## Works on any collection and custom iterators
## 
## Arguments
## 		value (*): The value to convert.
## Returns
## 		(Array): Returns the converted array.
## Example
## 		GD_.to_array({ 'a': 1, 'b': 2 });
## 		# => [1, 2]
## 		 
## 		GD_.to_array('abc');
## 		# => ['a', 'b', 'c']
## 		 
## 		GD_.to_array(1);
## 		# => []
## 		 
## 		GD_.to_array(null);
## 		# => []
static func to_array(thing):
    var array = []
    if GD_.is_custom_iterator(thing):
        for i in thing:
            array.append(i)
    else:
        for key in keyed_iterable(thing):
            array.append(thing[key])
    return array
static func to_finite(value): 
    if value is float or value is int and !is_nan(value) and !value == 9223372036854775807 :
        return value
    return 9223372036854775807

static func to_integer(a=0, b=0, c=0): not_implemented()
static func to_length(a=0, b=0, c=0): not_implemented()
static func to_number(a=0, b=0, c=0): not_implemented()
static func to_plain_object(a=0, b=0, c=0): not_implemented()
static func to_safe_integer(a=0, b=0, c=0): not_implemented()
#static func to_string(a=0, b=0, c=0): not_implemented()

"""
CATEGORY: MATH
"""
static func add(a=0, b=0, c=0): not_implemented()
#static func ceil(a=0, b=0, c=0): not_implemented()
static func divide(a=0, b=0, c=0): not_implemented()

## Computes number rounded down to precision. This uses Godot's floor
## internally but precision can be added.
##
##
## Arguments
## 		number (number): The number to round down.
## 		[precision=0] (number): The precision to round down to.
## Returns
## 		(number): Returns the rounded down number.
## Example
## 		GD_.floor(4.006)
## 		# => 4
## 		 
## 		GD_.floor(0.046, 2)
## 		# => 0.04
## 		 
## 		GD_.floor(4060, -2)
## 		# => 4000
static func floor(number, precision = null):
    var scale = pow(10.0, default_to(precision,0))
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
CATEGORY: NUMBER
"""

#static func clamp(a=0, b=0, c=0): not_implemented()

static func in_range(a=0, b=0, c=0): not_implemented()

## Produces a random number between the inclusive `lower` and `upper` bounds.
## If only one argument is provided a number between `0` and the given number
## is returned. If `floating` is `true`, or either `lower` or `upper` are
## floats, a floating-point number is returned instead of an integer.
## 
## Arguments
## 		[lower=0] (number): The lower bound.
## 		[upper=1] (number): The upper bound.
## 		floating (bool): Specify returning a floating-point number.
## Returns
##		(number): Returns the random number.
## Example
## 		random(0, 5)
## 		# => an integer between 0 and 5
##
## 		random(5)
## 		# => also an integer between 0 and 5
##
## 		random(5, true)
## 		# => a floating-point number between 0 and 5
##
## 		random(1.2, 5.2)
## 		# => a floating-point number between 1.2 and 5.2
## Notes:
##		>> @TODO guarded method by map, every, filter, mapValues, reject, some
static func random(lower=0, upper=0, floating:bool=false):
    # @TODO guarded method by map, every, filter, mapValues, reject, some
    if not floating:
        if upper is bool:
            floating = upper
            upper = null
        elif lower is bool:
            floating = lower
            lower = null
        
    if not lower or lower != lower and not upper:
        lower = 0
        upper = 1
    else:
        upper = to_finite(upper)
    
    if lower > upper:
        var temp = lower
        lower = upper
        upper = temp
        
    if floating or lower is float or upper is float:
        var rand = randf()
        var rand_length = str(rand).length() - 1
        return float(min(lower + rand * (upper - lower + (1.0 * pow(10, 1))), upper))
    return int(lower + floor(randf() * (upper - lower + 1)))

"""
CATEGORY: OBJECT
"""
static func assign(a=0, b=0, c=0): not_implemented() # @TODO guarded by reduce, reduceRight, transform
static func assign_in(a=0, b=0, c=0): not_implemented()
static func assign_in_with(a=0, b=0, c=0): not_implemented()
static func assign_with(a=0, b=0, c=0): not_implemented()

## Creates an array of values corresponding to paths of object.
## 
## 
## Arguments
## 		object (Object): The object to iterate over.
## 		[paths] (...(string|string[])): The property paths to pick.
## Returns
## 		(Array): Returns the picked values.
## Example
## 		var object = { 'a': [{ 'b': { 'c': 3 } }, 4] }
## 		 
## 		GD_.at(object, ['a[0].b.c', 'a[1]'])
## 		# => [3, 4]
##
##		GD_.at(['a', 'b', 'c'], 0,2)
##		# => ['a','c']
##
## Notes
##		>> Variable Arguments
##			In js you can call an infinite amount of args using ellipses 
##			E.g. _.at([], 1,2,3,4,5,6,7,"as many as you want",10)
##
##			But in GD_ you can call at most up to 10 args
##			E.g. GD_.at([], 1,2,3,4,5,6,7,8,9)
static func at(obj, a,b=_UNDEF_,c=_UNDEF_,d=_UNDEF_,e=_UNDEF_,f=_UNDEF_,g=_UNDEF_,h=_UNDEF_,i=_UNDEF_,j=_UNDEF_):
    return __INTERNAL__.base_at(obj, [a,b,c,d,e,f,g,h,i,j])
    

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


## Gets the value at path of object. If the resolved value is null, 
## the defaultValue is returned in its place.
## This is similar to lodash's get but renamed due to name clashes.
##
##
## When using string paths, delimit them with the ":" key e.g."a:b:c"
## Or use the index access notation "a['b']['c']"
##
## Arguments
## 		object (Object): The object to query.
## 		path (Array|string): The path of the property to get.
## 		[defaultValue] (*): The value returned for null resolved values.
## Returns
## 		(*): Returns the resolved value.
## Example
## 		GD_.get_prop({ 'a': [{ 'b': { 'c': 3 } }] }, 'a:0:b:c')
## 		# => 3
## 		 
## 		GD_.get_prop({ 'a': [{ 'b': { 'c': 3 } }] }, ['a', 0, 'b', 'c'])
## 		# => 3
## 		 
## 		GD_.get_prop({ 'a': {}, 'a:b:c', 'default')
## 		# => 'default'
##
##		GD_.get_prop([1,2,[3]], '2:1') 
##		# => 3
##
##		GD_.get_prop([ {'120':'string', 120: 'number'} ], '0[120]')
##		# => number
##
##		GD_.get_prop([ {'120':'string', 120: 'number'} ], '0['120']')
##		# => string
## Notes
##		>> Regarding integer keys
##			In js ["0", -0, 0] are "the same keys" when applied to an object
##			e.g. declaring {"0":"hello",0:"world"} in JS results in  {0:"world"}
##			But in gdscript ["0"] is a different key from [-0,0]
##			e.g. declaring {"0":"hello",0:"world"} in GODOT in {"0":"hello",0:"world"} 
## 		
##			Meaning in js
##			_.get( thing, "0") == _.get( thing, -0) == _.get( thing, 0)
##			And in godot
##			_.get( thing, "0") != (_.get( thing, -0) == _.get( thing, 0))
##
##		>> Regarding function returns
##			In js you can fetch a function like this _.get([],"push")
##			But in gdscript you can't really do this without knowing that
##			The said thing is a Callable or a property
static func get_prop(thing, path, default_value = null):
    var splits
    if path is String:
        var result = GD_.get_prop(thing, [path], null)
        if result:
            return result
        splits = __INTERNAL__.string_to_path(path)
    elif path is Array:
        splits = path
    elif GD_.is_number(path):
        splits = [path]
    else:
        gd_warn("GD_.get_prop received a non-collection type PATH")
        print_stack()
        return default_value
        
    if not(splits):
        return default_value
    
    var curr_prop = thing
    for split in splits:
        if curr_prop is Object:
            var innnn = split in curr_prop
            if split in curr_prop:
                var attempt = curr_prop.get(split)
                if attempt != null:
                    curr_prop = attempt
                    continue
                else:
                    return null
            else:
                return default_value # which is null
        if curr_prop is Dictionary:
            if split in curr_prop: 
                curr_prop = curr_prop[split]
                continue
            # As of 4.2 theres a bug where `&"" in {"":1}` results in a false
            # If we rewrap with str it becomes usable again
            # See https://github.com/godotengine/godot/issues/77894
            # See https://github.com/godotengine/godot/pull/70096
            elif split is StringName and str(split) in curr_prop: 
                curr_prop = curr_prop[str(split)]
                continue
            elif split is String and split.is_valid_int():
                curr_prop = curr_prop[int(split)]
                continue
            elif split is int and split in curr_prop:
                curr_prop = curr_prop[split]
                continue
            else:
                return default_value # which is null
        if curr_prop is Array \
            and __INTERNAL__.is_int_like(split) \
            and int(split) < curr_prop.size():
                curr_prop = __INTERNAL__.get_index(curr_prop,int(split))
                continue
        
        # Expensive but atleast it follows, Lodash behavior
        gd_warn("Warning: '%s' accesses a non-`Object`'s property which is expensive (e.g. Vector2 is a non-Object). Consider a different strategy" % &":".join(splits))
        var expression = Expression.new()
        var payload = "item['%s']" % split
        var result = expression.parse(payload,["item"])
        
        if result == OK:
            var tmp = expression.execute([curr_prop])
            if not(expression.has_execute_failed()):
                curr_prop = tmp
                continue
            
        return default_value
    return curr_prop
    
    
static func has(a=0, b=0, c=0): not_implemented()
static func has_in(a=0, b=0, c=0): not_implemented()
# @TODO guarded method by map, every, filter, mapValues, reject, some
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

static func values(collection): not_implemented()
static func values_in(a=0, b=0, c=0): not_implemented()


"""
CATEGORY: STRING
"""

static func camel_case(): not_implemented()
static func capitalize(): not_implemented()
static func deburr(): not_implemented()
static func ends_with(): not_implemented()
static func escape(): not_implemented()
static func escape_reg_exp(): not_implemented()
static func kebab_case(): not_implemented()
static func lower_case(a:String, _UNUSED_ = null): not_implemented()
static func lower_first(): not_implemented()
static func pad(): not_implemented()
static func pad_end(): not_implemented()
static func pad_start(): not_implemented()
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func parse_int(): not_implemented() 
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func repeat(): not_implemented() 
static func replace(): not_implemented()
static func snake_case(): not_implemented()
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func split(): not_implemented() 
static func start_case(): not_implemented()
static func starts_with(): not_implemented()

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func template(): not_implemented() 

## Wrapper for "string" to_lower. Allows for use as an iterator
## 
## Arguments
## 		[string=''] (string): The string to convert.
## Returns
## 		(string): Returns the lower cased string.
## Notes
##		>> @TODO needs to be revisited
##			to_lower behaves a bit differently from lodash's to_lower
static func to_lower(a:String, _UNUSED_ = null): 
    return a.to_lower()
    
static func to_upper(): not_implemented()

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func trim(): not_implemented() 
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func trim_end(): not_implemented() 
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func trim_start(): not_implemented() 
static func truncate(): not_implemented()
static func unescape(): not_implemented()
static func upper_case(): not_implemented()
static func upper_first(): not_implemented()
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func words(): not_implemented() 

"""
CATEGORY: UTILS
"""

static func attempt(a=0, b=0, c=0): not_implemented()
static func bind_all(a=0, b=0, c=0): not_implemented()
static func cond(a=0, b=0, c=0): not_implemented()
static func conforms(a=0, b=0, c=0): not_implemented()

## Creates a function that returns value.
## 
## 
## Arguments
## 		value (*): The value to return from the new function.
## Returns
## 		(Function): Returns the new constant function.
## Example
## 		var objects = GD_.map([0,0], GD_.constant({ 'a': 1 }))
## 		 
## 		print(objects)
## 		# => [{ 'a': 1 }, { 'a': 1 }]
## 		 
## 		print(objects[0] === objects[1])
## 		# => true
## 
static func constant(value = null, _UNUSED_ = null): return __INTERNAL__.base_constant(value,_UNUSED_)

## Checks value to determine whether a default value should be returned 
## in its place. The defaultValue is returned if value is NaN or null
## 
## Arguments
## 		value (*): The value to check.
## 		defaultValue (*): The default value.
## Returns
## 		(*): Returns the resolved value.
## Example
## 		GD_.default_to(1, 10)
## 		# => 1
## 		 
## 		GD_.default_to(null, 10)
## 		# => 10
static func default_to(a,b): 
    match typeof(a):
        TYPE_NIL:
            return b
        TYPE_INT:
            return b if is_nan(a) else a
        TYPE_FLOAT:
            return b if is_nan(a) else a
        TYPE_OBJECT:
            return b if is_same(a,_UNDEF_) or not(a) else a
    return a
    
    
static func flow(a=0, b=0, c=0): not_implemented()
static func flow_right(a=0, b=0, c=0): not_implemented()

## This method returns the first argument it receives.
## 
## Arguments
## 		value (*): Any value.
## Returns
## 		(*): Returns value.
## Example
## 		var object = { 'a': 1 }
##  
## 		print(is_same(GD_.identity(object),object))
## 		# => true
static func identity(value, _unused = null): 
    return value
    
## Converts shorthands to callables for use in other funcs
##
## Arguments
## 		[func=GD_.identity] (*): The value to convert to a callback.
## Returns
## 		(Function): Returns the callback.
## Example
## 		var users = [
## 		  { 'user': 'barney', 'age': 36, 'active': true },
## 		  { 'user': 'fred',   'age': 40, 'active': false }
## 		]
## 		 
## 		# The `GD_.matches` iteratee shorthand.
## 		GD_.filter(users, GD_.iteratee({ 'user': 'barney', 'active': true }))
## 		# => [{ 'user': 'barney', 'age': 36, 'active': true }]
## 		 
## 		# The `GD_.matches_property` iteratee shorthand.
## 		GD_.filter(users, GD_.iteratee(['user', 'fred']))
## 		# => [{ 'user': 'fred', 'age': 40 }]
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.map(users, GD_.iteratee('user'))
## 		# => ['barney', 'fred']
static func iteratee(iteratee_val):
    return __INTERNAL__.iteratee(iteratee_val)

## Creates a function that perform a comparison between a 
## given object and source, returning true if the given object has equivalent 
## property values, else false.
##
## Arguments
## 		source (Object): The object of property values to match.
## Returns
## 		(Function): Returns the new spec function.
## Example
## 		var objects = [
## 		  { 'a': 1, 'b': 2, 'c': 3 },
## 		  { 'a': 4, 'b': 5, 'c': 6 }
## 		]
## 		 
## 		GD_.filter(objects, _.matches({ 'a': 4, 'c': 6 }))
## 		# => [{ 'a': 4, 'b': 5, 'c': 6 }]
static func matches(dict:Dictionary) -> Callable:
    return __INTERNAL__.matches(dict)


## Creates a function that performs a partial deep comparison between 
## the value at path of a given object to srcValue, returning true if the 
## object value is equivalent, else false. Note: Partial comparisons will 
## match empty array and empty object srcValue values against any array 
## or object value, respectively. 
## 
## Arguments
## 		path (Array|string): The path of the property to get.
## 		srcValue (*): The value to match.
## Returns
## 		(Function): Returns the new spec function.
## Example
## 		var objects = [
## 		  { 'a': 1, 'b': 2, 'c': 3 },
## 		  { 'a': 4, 'b': 5, 'c': 6 }
## 		]
## 		 
## 		GD_.find(objects, GD_.matches_property('a', 4))
## 		# => { 'a': 4, 'b': 5, 'c': 6 }
static func matches_property(string:String, v):
    return __INTERNAL__.matches_property(string, v)
        
        
static func method(a=0, b=0, c=0): not_implemented()
static func method_of(a=0, b=0, c=0): not_implemented()
static func mixin(a=0, b=0, c=0): not_implemented()
static func no_conflict(a=0, b=0, c=0): not_implemented()


## This method returns null.
##
##
## Example
## 		GD_.times(2, GD_.noop)
## 		# => [null, null]
static func noop(a=0,b=0,c=0,d=0,e=0,f=0,g=0,h=0,i=0,j=0,k=0,l=0,m=0,n=0,o=0,p=0): 
    return null
            
static func nth_arg(a=0, b=0, c=0): not_implemented()
static func over(a=0, b=0, c=0): not_implemented()
static func over_every(a=0, b=0, c=0): not_implemented()
static func over_some(a=0, b=0, c=0): not_implemented()

## Creates a function that returns the value at path of a given object.	
##
##
## Arguments
## 		path (Array|string): The path of the property to get.
## Returns
## 		(Function): Returns the new accessor function.
## Example
## 		var objects = [
## 		  { 'a': { 'b': 2 } },
## 		  { 'a': { 'b': 1 } }
## 		]
## 		 
## 		GD_.map(objects, GD_.property('a:b'))
## 		# => [2, 1]
## 
##		var node = Node2D.new()
##		node.global_position = Vector2(15,10)
##		var fn = GD_.property("global_position:x")
##		fn.call(node) 
##		# => 15
static func property(path):
    return __INTERNAL__.property(path)
    
        
static func property_of(a=0, b=0, c=0): not_implemented()
# @TODO guarded method by map, every, filter, mapValues, reject, some
#static func range(a=0, b=0, c=0): not_implemented() 
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func range_right(a=0, b=0, c=0): not_implemented() 
static func run_in_context(a=0, b=0, c=0): not_implemented()
static func stub_array(a=0, b=0, c=0): not_implemented()
static func stub_false(a=0, b=0, c=0): not_implemented()
static func stub_object(a=0, b=0, c=0): not_implemented()
static func stub_string(a=0, b=0, c=0): not_implemented()
static func stub_true(a=0, b=0, c=0): not_implemented()


## Invokes the iteratee n times, returning an array of the results of 
## each invocation. The iteratee is invoked with two args (index, _UNUSED_)
## 
## 
## Arguments
## 		n (number): The number of times to invoke iteratee.
## 		[iteratee=GD_.identity] (Function): The function invoked per iteration.
## Returns
## 		(Array): Returns the array of results.
## Example
## 		GD_.times(3, GD_.to_string)
## 		# => ['0', '1', '2']
## 		 
## 		 GD_.times(4, func (a,b): return 0)
## 		# => [0, 0, 0, 0]
static func times(n=0, iteratee = GD_.identity): 
    var ary = []
    var iter_func = iteratee(iteratee)
    
    for i in range(n):
        ary.append(iter_func.call(i,null))
        
    return ary
    
static func to_path(a=0, b=0, c=0): not_implemented()

## Generates a unique ID. If prefix is given, the ID is appended to it.
##
##
## Arguments
## 		[prefix=''] (string): The value to prefix the ID with.
## Returns
## 		(string): Returns the unique ID.
## Example
## 		GD_.unique_id('contact_')
## 		# => 'contact_104'
## 		 
## 		GD_.unique_id()
## 		# => '105'
static func unique_id(prefix=&""): 
    return __INTERNAL__.base_unique_id(prefix)

"""
NON-LODASH FUNCS
"""	

## Ensures that when it iterates through the item, it always iterates via keys
## This does not have a lodash equivalent	
static func keyed_iterable(thing, from_index = 0):
    return __INTERNAL__.keyed_iterable(thing, from_index)
