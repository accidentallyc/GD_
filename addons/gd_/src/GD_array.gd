extends "./GD_collection.gd"


"""
CATEGORY: Array
"""

## Creates an array of elements split into groups the length of size. 
## If array can't be split evenly, the final chunk will be the remaining elements.
##
## Arguments
##      array (Array): The array to process.
##      [size=1] (number): The length of each chunk
## Returns
##      (Array): Returns the new array of chunks.
## Example
##      GD_.chunk(['a', 'b', 'c', 'd'], 2)
##      # => [['a', 'b'], ['c', 'd']]
##       
##      GD_.chunk(['a', 'b', 'c', 'd'], 3)
##      # => [['a',* 'b', 'c'], ['d']]
## Notes
##     >> Credit
##      Thanks to cyberreality for the quick code they offered to the community
##      https://www.reddit.com/r/godot/comments/e6ae27/comment/f9p3c2e
##      >> @TODO guarded method by map, every, filter, mapValues, reject, some
static func chunk(array:Array,size=1): 
    var new_array = []
    var i = 0
    var j = -1
    for item in array:
        if i % size == 0:
            new_array.append([])
            j += 1
        new_array[j].append(item)
        i += 1
    return new_array
                
                
## Creates an array with all falsey values removed. 
## The falsiness is determined by a basic if statement.
## The values false, null, 0, "", [], and {} are falsey.
##
## Arguments
##      array (Array): The array to process.
##      [size=1] (number): The length of each chunk
## Returns
##      (Array): Returns the new array of chunks.
## Example
##      GD_.compact([0, 1, false, 2, '', 3])
##      # => [1, 2, 3]
static func compact(array:Array, _UNUSED_ = null):
    var new_array = []
    for item in array:
        if item:
            new_array.append(item)
    return new_array
        
        
## Creates a new array concatenating array with any additional arrays and/or values.
## This func can receive up to 10 concat values. Hopefully thats enough
##
## Arguments
##      array (Array): The array to concatenate.
##      [values] (...*): The values to concatenate.
## Returns
##      (Array): Returns the new concatenated array.
## Example
##      var array = [1]
##      var other = GD_.concat(array, 2, [3], [[4]])
##       
##      print(other)
##      # => [1, 2, 3, [4]]
##       
##      print(array)
##      # => [1]
static func concat(array:Array, a=GD_UNDEF,b=GD_UNDEF,c=GD_UNDEF,d=GD_UNDEF,e=GD_UNDEF,f=GD_UNDEF,g=GD_UNDEF,h=GD_UNDEF,i=GD_UNDEF,j=GD_UNDEF,k=GD_UNDEF):
    return __INTERNAL__.base_concat(array,[a,b,c,d,e,f,g,h,i,j,k])
                
            
## Creates an array of array values not included in the other given arrays 
## using == for comparisons. The order and references of result values 
## are determined by the first array.
##
## Arguments
##      array (Array): The array to inspect.
##      [values] (...Array): The values to exclude.
## Returns
##      (Array): Returns the new array of filtered values.
## Example
##      GD_.difference([2, 1], [2, 3])
##      # => [1]
static func difference(array_left:Array, array_right:Array): 	
    var new_array = []
    new_array.append_array(array_left)
    
    for array_item_2 in array_right:
        new_array.erase(array_item_2)
        
    return new_array

## This method is like GD_.difference except that it accepts iteratee which 
## is invoked for each element of array and values to generate the criterion 
## by which they're compared using ==. The order and references of result 
## values are determined by the first array. The iteratee is 
## invoked with two arguments: (value, _UNUSED_)
##
## Arguments
##     array (Array): The array to inspect.
##     [values] (...Array): The values to exclude.
##     [iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
##     (Array): Returns the new array of filtered values.
## Example
##      GD_.difference_by([2.1, 1.2], [2.3, 3.4], Math.floor)
##      # => [1.2]
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.difference_by([{ 'x': 2 }, { 'x': 1 }], [{ 'x': 1 }], 'x')
##      # => [{ 'x': 2 }]
static func difference_by(array_left, array_right, iteratee = GD_.identity): 
    var iter_func = iteratee(iteratee)
        
    # new return array
    var new_array = []
    
    # store processed keyes here
    var keys_to_remove_map = {}
    for array_item_2 in array_right:
        keys_to_remove_map[iter_func.call(array_item_2, null)] = true
        
    var array_right_max = array_left.size()
    
    for left_item in array_left:
        var left_key = iter_func.call(left_item, null)
        if not(keys_to_remove_map.has(left_key)):
            new_array.append(left_item)
            
    return new_array
    
    
## This method is like GD_.difference except that it accepts comparator 
## which is invoked to compare elements of array to values. 
## The order and references of result values are determined by the first array. 
## The comparator is invoked with two arguments: (arrVal, othVal).
##
## Arguments
##      array (Array): The array to inspect.
##      [values] (...Array): The values to exclude.
##      [comparator] (Function): The comparator invoked per element.
## Returns
##      (Array): Returns the new array of filtered values.
## Example
##      var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]
##       
##      GD_.difference_with(objects, [{ 'x': 1, 'y': 2 }], GD_.is_equal)
##      # => [{ 'x': 2, 'y': 1 }]
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
##      array (Array): The array to query.
##      [n=1] (number): The number of elements to drop.
## Returns
##      (Array): Returns the slice of array.
## Example
##      GD_.drop([1, 2, 3])
##      # => [2, 3]
##       
##      GD_.drop([1, 2, 3], 2)
##      # => [3]
##       
##      GD_.drop([1, 2, 3], 5)
##      # => []
##       
##      GD_.drop([1, 2, 3], 0)
##      # => [1, 2, 3]
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
##      array (Array): The array to query.
##      [n=1] (number): The number of elements to drop.
## Returns
##      (Array): Returns the slice of array.
## Example
##      GD_.drop_right([1, 2, 3])
##      # => [1, 2]
##      
##      GD_.drop_right([1, 2, 3], 2)
##      # => [1]
##       
##      GD_.drop_right([1, 2, 3], 5)
##      # => []
##       
##      GD_.drop_right([1, 2, 3], 0)
##      # => [1, 2, 3]
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
##      array (Array): The array to query.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (Array): Returns the slice of array.
## Example
##      var users = [
##        { 'user': 'barney',  'active': true },
##        { 'user': 'fred',    'active': false },
##        { 'user': 'pebbles', 'active': false }
##      ]
##       
##      GD_.drop_right_while(users, func (o,_unused): return !o.active)
##      # => objects for ['barney']
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.drop_right_while(users, { 'user': 'pebbles', 'active': false })
##      # => objects for ['barney', 'fred']
##       
##      # The `GD_.matches_property` iteratee shorthand.
##      GD_.drop_right_while(users, ['active', false])
##      # => objects for ['barney']
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.drop_right_while(users, 'active')
##      # => objects for ['barney', 'fred', 'pebbles']
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
##      array (Array): The array to query.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (Array): Returns the slice of array.
## Example
##      var users = [
##        { 'user': 'barney',  'active': false },
##        { 'user': 'fred',    'active': false },
##        { 'user': 'pebbles', 'active': true }
##      ]
##       
##      GD_.drop_while(users, func (o, _unused): return !o.active )
##      # => objects for ['pebbles']
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.drop_while(users, { 'user': 'barney', 'active': false })
##      # => objects for ['fred', 'pebbles']
##       
##      # The `GD_.matches_property` iteratee shorthand.
##      GD_.drop_while(users, ['active', false])
##      # => objects for ['pebbles']
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.drop_while(users, 'active')
##      # => objects for ['barney', 'fred', 'pebbles']
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
##      array (Array): The array to fill.
##      value (*): The value to fill array with.
##      [start=0] (number): The start position.
##      [end=array.length] (number): The end position.
## Returns
##      (Array): Returns array.
## Example
##      var array = [1, 2, 3]
##       
##      GD_.fill(array, 'a')
##      print(array)
##      # => ['a', 'a', 'a']
##       
##      GD_.fill(Array(3), 2)
##      # => [2, 2, 2]
##       
##      GD_.fill([4, 6, 8, 10], '*', 1, 3)
##      # => [4, '*', '*', 10]
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
##      array (Array): The array to inspect.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
##      [fromIndex=0] (number): The index to search from.
## Returns
##      (number): Returns the index of the found element, else -1.
## Example
##      var users = [
##        { 'user': 'barney',  'active': false },
##        { 'user': 'fred',    'active': false },
##        { 'user': 'pebbles', 'active': true }
##      ]
##       
##      GD_.find_index(users, func (o, _i): return o.user == 'barney' )
##      # => 0
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.find_index(users, { 'user': 'fred', 'active': false })
##      # => 1
##       
##      # The `GD_.matches_property` iteratee shorthand.
##      GD_.find_index(users, ['active', false])
##      # => 0
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.find_index(users, 'active')
##      # => 2
static func find_index(array:Array, predicate = GD_.identity, from_index = 0):
    var iteratee = iteratee(predicate)
    for i in range(from_index, array.size()):
        if iteratee.call(array[i], null):
            return i
    return -1
    
    
## This method is like GD_.findIndex except that it iterates over 
## elements of collection from right to left.
##
## Arguments
##      array (Array): The array to inspect.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
##      [fromIndex=array.length-1] (number): The index to search from.
## Returns
##      (number): Returns the index of the found element, else -1.
## Example
##      var users = [
##        { 'user': 'barney',  'active': true },
##        { 'user': 'fred',    'active': false },
##        { 'user': 'pebbles', 'active': false }
##      ]
##       
##      GD_.find_last_index(users, func(o,_index): return o.user == 'pebbles')
##      # => 2
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.find_last_index(users, { 'user': 'barney', 'active': true })
##      # => 0
##       
##      # The `GD_.matches_property` iteratee shorthand.
##      GD_.find_last_index(users, ['active', false])
##      # => 2
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.find_last_index(users, 'active')
##      # => 0
static func find_last_index(array:Array, predicate = GD_.identity, from_index=-1):
    if from_index == -1 or from_index >= array.size():
        from_index = array.size() - 1

    var iter_func = iteratee(predicate)
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
##      array (Array): The array to flatten.
## Returns
##      (Array): Returns the new flattened array.
## Example
##      GD_.flatten([1, [2, [3, [4]], 5]])
##      # => [1, 2, [3, [4]], 5]
static func flatten(array:Array): 
    return flatten_depth(array, 1)
    

## Recursively flattens array.
##
## Arguments
##      array (Array): The array to flatten.
## Returns
##      (Array): Returns the new flattened array.
## Example
##     GD_.flatten_deep([1, [2, [3, [4]], 5]])
##     # => [1, 2, 3, 4, 5]
static func flatten_deep(array:Array):
    return flatten_depth(array, INF)
    

## Recursively flatten array up to depth times.
##
## Arguments
##      array (Array): The array to flatten.
##      [depth=1] (number): The maximum recursion depth.
## Returns
##      (Array): Returns the new flattened array.
## Example
##      var array = [1, [2, [3, [4]], 5]]
##       
##      GD_.flatten_depth(array, 1)
##      # => [1, 2, [3, [4]], 5]
##       
##      GD_.flatten_depth(array, 2)
##      # => [1, 2, 3, [4], 5]
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
##      pairs (Array): The key-value pairs.
## Returns
##      (Object): Returns the new object.
## Example
##     GD_.from_pairs([['a', 1], ['b', 2]])
##     # => { 'a': 1, 'b': 2 }
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
##      GD_.first
## Arguments
##      array (Array): The array to query.
## Returns
##      (*): Returns the first element of array.
## Example
##     GD_.head([1, 2, 3])
##     # => 1
##      
##     GD_.head([])
##     # => null
static func head(array:Array):
    return array[0] if array.size() else null
    

## Gets the index at which the first occurrence of value is found in array 
## using == for equality comparisons. If fromIndex is negative, 
## it's used as the offset from the end of array.
##
## Arguments
##      array (Array): The array to inspect.
##      value (*): The value to search for.
##      [fromIndex=0] (number): The index to search from.
## Returns
##      (number): Returns the index of the matched value, else -1.
## Example
##     GD_.index_of([1, 2, 1, 2], 2)
##     # => 1
##      
##     # Search from the `fromIndex`.
##     GD_.index_of([1, 2, 1, 2], 2, 2)
##     # => 3
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
##      array (Array): The array to query.
## Returns
##      (Array): Returns the slice of array.
## 	Example
##     GD_.initial([1, 2, 3])
##     # => [1, 2]
static func initial(array:Array):
    var copy = array.duplicate() 
    copy.pop_back()
    return copy
    

## Creates an array of unique values that are included in all given 
## arrays using == for equality comparisons. The order and references of 
## result values are determined by the first array.
##
## Arguments
##      [arrays] (...Array): The arrays to inspect.
## Returns
##      (Array): Returns the new array of intersecting values.
## Example
##      GD_.intersection([2, 1], [2, 3])
##      # => [2]
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
##      [arrays] (...Array): The arrays to inspect.
##      [iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
##      (Array): Returns the new array of intersecting values.
## Example
##     GD_.intersection_by([2.1, 1.2], [2.3, 3.4], GD_.floor)
##     # => [2.1]
##      
##     # The `GD_.property` iteratee shorthand.
##     GD_.intersection_by([{ 'x': 1 }], [{ 'x': 2 }, { 'x': 1 }], 'x')
##     # => [{ 'x': 1 }]
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
##      [arrays] (...Array): The arrays to inspect.
##      [comparator] (Function): The comparator invoked per element.
## Returns
##      (Array): Returns the new array of intersecting values.
## Example
##      var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]
##      var others = [{ 'x': 1, 'y': 1 }, { 'x': 1, 'y': 2 }]
##       
##      GD_.intersection_with(objects, others, GD_.is_equal)
##      # => [{ 'x': 1, 'y': 2 }]
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
            
    var all = []
    for i in max:
        all.append_array(arrays[i])
    
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
##      array (Array): The array to convert.
##      [separator=','] (string): The element separator.
## Returns
##      (string): Returns the joined string.
## Example
##      GD_.join(['a', 'b', 'c'], '~')
##      # => 'a~b~c'
static func join(array:Array, separator=&','):
    return separator.join(array)
        
        
## Gets the last element of array.
##
## Arguments
##      array (Array): The array to query.
## Returns
##      (*): Returns the last element of array.
## Example
##      GD_.last([1, 2, 3])
##      # => 3
static func last(array:Array):
    return array.back()
    
    
## This method is like GD_.index_of except that it iterates 
## over elements of array from right to left.
##
## Arguments
##      array (Array): The array to inspect.
##      value (*): The value to search for.
##      [fromIndex=array.length-1] (number): The index to search from.
## Returns
##      (number): Returns the index of the matched value, else -1.
## Example
##      GD_.last_index_of([1, 2, 1, 2], 2)
##      # => 3
##       
##      # Search from the from_index`.
##      GD_.last_index_of([1, 2, 1, 2], 2, 2)
##      # => 1
static func last_index_of(array:Array, search, from_index = null ): 
    var size = array.size()
    from_index = super.default_to(from_index, size -1)
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
##      array (Array): The array to query.
##      [n=0] (number): The index of the element to return.
## Returns
##      (*): Returns the nth element of array.
## Example
##      var array = ['a', 'b', 'c', 'd']
##       
##      GD_.nth(array, 1)
##      # => 'b'
##       
##      GD_.nth(array, -2)
##      # => 'c'
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
##      array (Array): The array to modify.
##      [values] (...*): The values to remove.
## Returns
##      (Array): Returns array.
## Example
##      var array = ['a', 'b', 'c', 'a', 'b', 'c']
##       
##      GD_.pull(array, 'a', 'c')
##      print(array)
##      # => ['b', 'b']
static func pull(array:Array, a=GD_UNDEF,b=GD_UNDEF,c=GD_UNDEF,d=GD_UNDEF,e=GD_UNDEF,f=GD_UNDEF,g=GD_UNDEF,h=GD_UNDEF,i=GD_UNDEF,j=GD_UNDEF): 
    var to_remove = super.filter([a,b,c,d,e,f,g,h,i,j], GD_UNDEF.is_defined)
    return pull_all_by(array, to_remove)
    

## This method is like _.pull except that it accepts an array of values to remove.
## Note: Unlike _.difference, this method mutates array.
## 
## Arguments
##      array (Array): The array to modify.
##      values (Array): The values to remove.
## Returns
##      (Array): Returns array.
## Example
##      var array = ['a', 'b', 'c', 'a', 'b', 'c']
##       
##      GD_.pull_all(array, ['a', 'c'])
##      print(array)
##      # => ['b', 'b']
static func pull_all(array:Array, values_to_remove:Array = _EMPTY_ARRAY_):           
    return pull_all_by(array, values_to_remove)
    
## This method is like GD_.pull_all except that it accepts iteratee 
## which is invoked for each element of array and values to generate 
## the criterion by which they're compared. The iteratee is invoked 
## with one argument: (value).
## Note: Unlike GD_.difference_by, this method mutates array.	
##
## Arguments
##      array (Array): The array to modify.
##      values (Array): The values to remove.
##      [iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
##      (Array): Returns array.
## Example
##      var array = [{ 'x': 1 }, { 'x': 2 }, { 'x': 3 }, { 'x': 1 }]
##       
##      GD_.pull_all_by(array, [{ 'x': 1 }, { 'x': 3 }], 'x')
##      # => [{ 'x': 2 }]
static func pull_all_by(array:Array, values_to_remove = _EMPTY_ARRAY_, iteratee = GD_.identity):
    values_to_remove = super.cast_array(values_to_remove)
    
    var iter_func = iteratee(iteratee)
    values_to_remove = values_to_remove \
            if iter_func == GD_.identity \
            else super.map(values_to_remove,iter_func)
    
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
##      array (Array): The array to modify.
##      values (Array): The values to remove.
##      [comparator] (Function): The comparator invoked per element.
## Returns
##      (Array): Returns array.
## Example
##      var array = [{ 'x': 1, 'y': 2 }, { 'x': 3, 'y': 4 }, { 'x': 5, 'y': 6 }]
##       
##      GD_.pull_all_with(array, [{ 'x': 3, 'y': 4 }], GD_.is_equal)
##      print(array)
##      # => [{ 'x': 1, 'y': 2 }, { 'x': 5, 'y': 6 }]
static func pull_all_with(array:Array, values_to_remove, comparator:Callable = GD_.is_equal):
    values_to_remove = cast_array(values_to_remove)
    
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
##      array (Array): The array to modify.
##      [indexes] (...(number|number[])): The indexes of elements to remove.
## Returns
##      (Array): Returns the new array of removed elements.
## Example
##      var array = ['a', 'b', 'c', 'd']
##      var pulled = GD_.pull_at(array, [1, 3])
##       
##      print(array)
##      # => ['a', 'c']
##       
##      print(pulled)
##      # => ['b', 'd']
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
##      array (Array): The array to modify.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (Array): Returns the new array of removed elements.
## Example
##      var array = [1, 2, 3, 4]
##      var evens = GD_.remove(array, func(n, _i):
##       return n % 2 == 0
##      )
##  	
##      print(array)
##      # => [1, 3]
##       
##      print(evens)
##      # => [2, 4]
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
##      array (Array): The array to modify.
## Returns
##      (Array): Returns array.
## Example
##      var array = [1, 2, 3]
##       
##      GD_.reverse(array)
##      # => [3, 2, 1]
##       
##      print(array)
##      # => [3, 2, 1]
static func reverse(array:Array):
    array.reverse()
    return array

## Creates a slice of array from start up to, but not including, end.
## 
## Note: This method is a wrapper for Godot's Array.slice
## 
## Arguments
##      array (Array): The array to slice.
##      [start=0] (number): The start position.
##      [end=array.length] (number): The end position.
## Returns
##      (Array): Returns the slice of array.
## Example
##     var array = [0,1,2,3,4]
##     var slice = GD_.slice(array,1,4)
##
##     print(slice)
##     # => [1,2,3]
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func slice(array:Array, start=0,end = array.size()): 
    return array.slice(start,end)
    

## Uses a binary search to determine the lowest index at which 
## value should be inserted into array in order to maintain its sort order.
## 
## 
## Arguments
##      array (Array): The sorted array to inspect.
##      value (*): The value to evaluate.
## Returns
##      (number): Returns the index at which value should be inserted into array.
## Example
##      GD_.sorted_index([30, 50], 40)
##      # => 1
static func sorted_index(array:Array, value):
    if not(is_number(value)):
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
##      array (Array): The sorted array to inspect.
##      value (*): The value to evaluate.
##      [iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
##      (number): Returns the index at which value should be inserted into array.
## Example
##      var objects = [{ 'x': 4 }, { 'x': 5 }]
##       
##      GD_.sorted_index_by(objects, { 'x': 4 }, func(o): return o.x)
##      # => 0
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.sorted_index_by(objects, { 'x': 4 }, 'x')
##      # => 0 
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
##      array (Array): The array to inspect.
##      value (*): The value to search for.
## Returns
##      (number): Returns the index of the matched value, else -1.
## Example
##      GD _.sorted_index_of([4, 5, 5, 5, 6], 5)
##      # => 1	
static func sorted_index_of(array:Array, value):
    if not(super.is_number(value)):
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
##      array (Array): The sorted array to inspect.
##      value (*): The value to evaluate.
## Returns
##      (number): Returns the index at which value should be inserted into array.
## Example
##      GD_.sorted_last_index([4, 5, 5, 5, 6], 5)
##      # => 4
static func sorted_last_index(array:Array, value):
    if not(super.is_number(value)):
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
##      array (Array): The sorted array to inspect.
##      value (*): The value to evaluate.
##      [iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
##      (number): Returns the index at which value should be inserted into array.
## Example
##      var objects = [{ 'x': 4 }, { 'x': 5 }]
##      GD_.sorted_last_index_by(objects, { 'x': 4 }, func(o,_u): return o.x)
##      # => 1
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.sorted_last_index_by(objects, { 'x': 4 }, 'x')
##      # => 1
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
##      array (Array): The array to inspect.
##      value (*): The value to search for.
## Returns
##      (number): Returns the index of the matched value, else -1.
## Example
##      GD_.sorted_last_index_of([4, 5, 5, 5, 6], 5)
##      # => 3
static func sorted_last_index_of(array:Array, value): 
    if not(super.is_number(value)):
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
##      array (Array): The array to inspect.
## Returns
##      (Array): Returns the new duplicate free array.
## Example
##      GD_.sorted_uniq([1, 1, 2])
##      # => [1, 2]
static func sorted_uniq(array:Array):
    return sorted_uniq_by(array)
    

## This method is like GD_.uniq_by except that it's designed and 
## optimized for sorted arrays.
## 
## 
## Arguments
##      array (Array): The array to inspect.
##      [iteratee] (Function): The iteratee invoked per element.
## Returns
##      (Array): Returns the new duplicate free array.
## Example
##      GD_.sorted_uniq_by([1.1, 1.2, 2.3, 2.4], Math.floor)
##      # => [1.1, 2.3]
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
##      array (Array): The array to query.
## Returns
##      (Array): Returns the slice of array.
## Example
##      GD_.tail([1, 2, 3])
##      # => [2, 3]
static func tail(array:Array, _UNUSED_ = null): 
    return array.slice(1)
    

## Creates a slice of array with n elements taken from the beginning.
## 
##
## Arguments
##      array (Array): The array to query.
##      [n=1] (number): The number of elements to take.
## Returns
##      (Array): Returns the slice of array.
## Example
##      GD_.take([1, 2, 3])
##      # => [1]
##       
##      GD_.take([1, 2, 3], 2)
##      # => [1, 2]
##       
##      GD_.take([1, 2, 3], 5)
##      # => [1, 2, 3]
##       
##      GD_.take([1, 2, 3], 0)
##      # => []
## Notes
##      >> This is a guarded method 
##      When used with methods like map, every, filter, mapValues, reject, some
##      it is invoked with all the optionals set as null
static func take(array:Array, n = GD_UNDEF): 
    var size = array.size()
    
    var lo = GD_UNDEF.is_undefined(n)
    if GD_UNDEF.is_undefined(n) or n == null: n = 1
    elif not(super.is_number(n)): n = -INF
    
    return array.slice(0, max(min(n,size),0))
    
    
## Creates a slice of array with n elements taken from the end.
## 
## Arguments
##      array (Array): The array to query.
##      [n=1] (number): The number of elements to take.
## Returns
##      (Array): Returns the slice of array.
## Example
##      GD_.take_right([1, 2, 3])
##      # => [3]
##       
##      GD_.take_right([1, 2, 3], 2)
##      # => [2, 3]
##       
##      GD_.take_right([1, 2, 3], 5)
##      # => [1, 2, 3]
##       
##      GD_.take_right([1, 2, 3], 0)
##      # => []
## Notes
##      >> This is a guarded method 
##      When used with methods like map, every, filter, mapValues, reject, some
##      it is invoked with all the optionals set as null
static func take_right(array:Array, n = null): 
    var size = array.size()
    
    if GD_UNDEF.is_undefined(n) or n == null: n = 1
    elif not(super.is_number(n)): n = -INF # to
    
    return array.slice(clamp(size-n,0,size), size)
    

## Creates a slice of array with elements taken from the end. 
## Elements are taken until predicate returns falsey. The predicate is invoked 
## with two arguments: (value, index).
## 
## Arguments
##      array (Array): The array to query.
##      [predicate=_.identity] (Function): The function invoked per iteration.
## Returns
##      (Array): Returns the slice of array.
## 
## Example
##      var users = [
##        { 'user': 'barney',  'active': true },
##        { 'user': 'fred',    'active': false },
##        { 'user': 'pebbles', 'active': false }
##      ]
##  
##      GD_.take_right_while(users, func(o,_u): return !o.active)
##      # => objects for ['fred', 'pebbles']
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.take_right_while(users, { 'user': 'pebbles', 'active': false })
##      # => objects for ['pebbles']
##       
##      # The `GD_.matchesProperty` iteratee shorthand.
##      GD_.take_right_while(users, ['active', false])
##      # => objects for ['fred', 'pebbles']
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.take_right_while(users, 'active')
##      # => []
static func take_right_while(array:Array, predicate = null):
    var size = array.size()
    
    predicate = iteratee(predicate)
    
    var n = size
    for i in range(size - 1, -1, -1):
        if not predicate.call(array[i], i): break
        n = i
            
    return take_right(array,n)

## Creates a slice of array with elements taken from the beginning. 
## Elements are taken until predicate returns falsey. The predicate is 
## invoked with three arguments: (value, index).
## 
## Arguments
##      array (Array): The array to query.
##      [predicate=_.identity] (Function): The function invoked per iteration.
## Returns
## (Array): Returns the slice of array.
## 
## Example
##      var users = [
##        { 'user': 'barney',  'active': false },
##        { 'user': 'fred',    'active': false },
##        { 'user': 'pebbles', 'active': true }
##      ]
##       
##      GD_.take_while(users, func (o,u): return !o.active )
##      # => objects for ['barney', 'fred']
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.take_while(users, { 'user': 'barney', 'active': false })
##      # => objects for ['barney']
##       
##      # The `GD_.matchesProperty` iteratee shorthand.
##      GD_.take_while(users, ['active', false])
##      # => objects for ['barney', 'fred']
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.take_while(users, 'active')
##      # => []  
static func take_while(array:Array, predicate = null):
    var size = array.size()
    
    predicate = iteratee(predicate)
    
    var n = 0
    for i in range(0, size):
        if not predicate.call(array[i], i): 
            break
        n = i
            
    return take(array,n + 1)

## Creates an array of unique values, in order, from all given arrays using 
## == for equality comparisons.
## 
## 
## Arguments
##      [arrays] (...Array): The arrays to inspect.
## Returns
##      (Array): Returns the new array of combined values.
## Example
##      GD_.union([2], [1, 2])
##      # => [2, 1]
##
##      GD_.union([1],[2],[3],[4],[5])
##      # => [1,2,3,4,5]
## Notes
##     >> Variable Arguments
##      In js you can call an infinite amount of args using ellipses 
##      E.g. "GD_.union([1],[2],[3],[4],[5],[6],[7],["as many as you want"],[10])
##
##      But in GD_ you can call at most up to 10 args
##      E.g. "GD_.union([1],[2],[3],[4],[5],[6],[7],[8],[9],[10])
static func union(a:Array, b:Array, c=GD_UNDEF,d=GD_UNDEF,e=GD_UNDEF,f=GD_UNDEF,g=GD_UNDEF,h=GD_UNDEF,i=GD_UNDEF,j=GD_UNDEF):
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
##      [arrays] (...Array): The arrays to inspect.
##      [iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
##      (Array): Returns the new array of combined values.
## Example
##      GD_.union_by([2.1], [1.2, 2.3], GD_.floor)
##      # => [2.1, 1.2]
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.union_by([{ 'x': 1 }], [{ 'x': 2 }, { 'x': 1 }], 'x')
##      # => [{ 'x': 1 }, { 'x': 2 }]
static func union_by(array_a:Array, array_b:Array, iteratee = GD_.identity):
    var array_c = array_a.duplicate()
    array_c.append_array(array_b)
    return uniq_by(array_c, iteratee)


## This method is like GD_.union except that it accepts comparator 
## which is invoked to compare elements of arrays. Result values are chosen 
## from the first array in which the value occurs. The comparator is invoked 
## with two arguments: (arrVal, othVal).
## 
## 
## Arguments
##      [arrays] (...Array): The arrays to inspect.
##      [comparator] (Function): The comparator invoked per element.
## Returns
##      (Array): Returns the new array of combined values.
## Example
##      var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]
##      var others = [{ 'x': 1, 'y': 1 }, { 'x': 1, 'y': 2 }]
##  
##      GD_.union_with(objects, others, GD_.is_equal)
##      # => [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }, { 'x': 1, 'y': 1 }]     
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
##      array (Array): The array to inspect.
## Returns
##      (Array): Returns the new duplicate free array.
## Example
##      GD_.uniq([2, 1, 2])
##      # => [2, 1]
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
##      array (Array): The array to inspect.
##      [iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
##      (Array): Returns the new duplicate free array.
## Example
##      GD_.uniq_by([2.1, 1.2, 2.3], Math.floor)
##      # => [2.1, 1.2]
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.uniq_by([{ 'x': 1 }, { 'x': 2 }, { 'x': 1 }], 'x')
##      # => [{ 'x': 1 }, { 'x': 2 }]
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
##      array (Array): The array to inspect.
##      [comparator] (Function): The comparator invoked per element.
## Returns
##      (Array): Returns the new duplicate free array.
## Example
##      var objects = [{'x':1,'y':2},{'x':2,'y':1},{'x':1,'y':2}]
##      GD_.uniq_with(objects, GD_.is_equal)
##      # => [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]	
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
    
static func unzip(args:Array):
    return unzip_with(args)

static func unzip_with(args:Array, iter_func = null):
    var biggest_size = __INTERNAL__.get_max_size_of_all_arrays(args)
    var result = []
    # Preconstructs results for easier accessing
    for tmp in  range(0, biggest_size): result.append([])
    
    
    for index in range(0, biggest_size):
        var arg_set = result[index]
        for arg_i in range(0, args.size()): 
            var ary = args[arg_i]
            var size = ary.size()
            # Get the array
            arg_set.append( null if index >= size else ary[index] )
        var slice = iter_func.callv(arg_set) if iter_func else arg_set
        result[index] = slice
    return result


## Creates an array excluding all given values using == for equality comparisons.
## 
## Note: Unlike GD_.pull, this method returns a new array.
## 
## 
## Arguments
##      array (Array): The array to inspect.
##      [values] (...*): The values to exclude.
## Returns
##      (Array): Returns the new array of filtered values.
## Example
##      GD_.without([2, 1, 2, 3], 1, 2)
##      # => [3]
static func without(array:Array, b=GD_UNDEF,c=GD_UNDEF,d=GD_UNDEF,e=GD_UNDEF,f=GD_UNDEF,g=GD_UNDEF,h=GD_UNDEF,i=GD_UNDEF,j=GD_UNDEF):
    var without_list = []
    for arg in [b,c,d,e,f,g,h,i,j]:
        if GD_UNDEF.is_undefined(arg): continue
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
        
## Creates an array of unique values that is the symmetric difference of the given arrays. The order of result values is determined by the order they occur in the arrays.
## 
## Arguments
##      [arrays] (...Array): The arrays to inspect.
## Returns
##      (Array): Returns the new array of filtered values.
## Example
##      GD_.xor([2, 1], [2, 3])
##      # => [1, 3]   
## Notes
##     >> Variable Arguments
##      In js you can call an infinite amount of args using ellipses 
##      E.g. _.xor([1], [2], [3],[4],  ... , [100], [101])
##
##      But in GD_ you can call at most up to 10 args
##      E.g. GD_.xor([1], [2], [3], ... , [10])
static func xor(arg1,arg2 = GD_UNDEF,arg3 = GD_UNDEF,arg4 = GD_UNDEF,arg5 = GD_UNDEF,arg6 = GD_UNDEF,arg7 = GD_UNDEF,arg8 = GD_UNDEF,arg9 = GD_UNDEF,arg10 = GD_UNDEF,arg11 = GD_UNDEF):
    return xor_with(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11)

## This method is like GD_.xor except that it accepts iteratee which is 
## invoked for each element of each arrays to generate the criterion by which 
## by which they're compared. The order of result values is determined by the 
## order they occur in the arrays. The iteratee is invoked 
## with two arguments: (value, _UNUSED_).
## 
## Arguments
##      [arrays] (...Array): The arrays to inspect.
##      [iteratee=_.identity] (Function): The iteratee invoked per element.
## Returns
##      (Array): Returns the new array of filtered values.
## Example
##      GD_.xor_by([2.1, 1.2], [2.3, 3.4], GD_.floor)
##      # => [1.2, 3.4]
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.xor_by([{ 'x': 1 }], [{ 'x': 2 }, { 'x': 1 }], 'x')
##      # => [{ 'x': 2 }]
## Notes
##     >> Variable Arguments
##      In js you can call an infinite amount of args using ellipses 
##      E.g. _.xor_by([1], [2], [3],[4],  ... , [100], [101],'x')
##
##      But in GD_ you can call at most up to 10 args
##      E.g. GD_.xor_by([1], [2], [3], ... , [10],'x')
static func xor_by(arg1,arg2 = GD_UNDEF,arg3 = GD_UNDEF,arg4 = GD_UNDEF,arg5 = GD_UNDEF,arg6 = GD_UNDEF,arg7 = GD_UNDEF,arg8 = GD_UNDEF,arg9 = GD_UNDEF,arg10 = GD_UNDEF,arg11 = GD_UNDEF):
    var args = __INTERNAL_ARGS__.new()
    args.last_is_iteratee(
        [arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11],
        GD_.is_equal
    )

    var differences = []
    var removed = []
    var arrays := args.all as Array
    var iter_func := super.iteratee(args.last_item) as Callable
    # Loop through all arrays
    for i in range(0,len(arrays)): 
        var ary = arrays[i]
        
        if not(GD_.is_array(ary)):
            gd_warn("GD_.intersection_with received a non-array type value")
            continue
        
        var added_this_iteration = []
        for item_raw in ary:
            var item = iter_func.call(item_raw, null)
            # See if its saved in removed, and if it is we pluck it out
            var item_index = super.map(differences, iter_func).find(item)
            if item_index > -1:
                # Item was added during this run - this means duplicate value
                # e.g. [1,2,3,1,1,1] - lets do nothing and move on
                if item in added_this_iteration: 
                    continue
                
                differences.remove_at(item_index)
                # Add to "deleted list" to not re-add it later via a diff array
                removed.append(item)
                continue
            elif item in removed:
                continue
            differences.append(item_raw) 
            added_this_iteration.append(item)
                
    return differences
    
## This method is like GD_.xor except that it accepts comparator which is 
## invoked to compare elements of arrays. The order of result values is 
## determined by the order they occur in the arrays. The comparator is invoked 
## with two arguments: (arrVal, othVal).
## 
## Arguments
##      [arrays] (...Array): The arrays to inspect.
##      [comparator] (Function): The comparator invoked per element.
## Returns
##      (Array): Returns the new array of filtered values.
## Example
##      var a1 = ["hello","foo"]
##      var a2 = ["bar","homer"]
##      var comparator = func (a,b): return a[0] == b[0]
##
##      GD_.xor_wth(a1, a2, comparator)
##      # => ["foo","bar"]
## Notes
##     >> Variable Arguments
##      In js you can call an infinite amount of args using ellipses 
##      E.g. _.xor_by([1], [2], [3],[4],  ... , [100], [101],GD_.is_equal)
##
##      But in GD_ you can call at most up to 10 args
##      E.g. GD_.xor_by([1], [2], [3], ... , [10],GD_.is_equal)
static func xor_with(arg1:Array,arg2 = null,arg3 = null,arg4 = null,arg5 = null,arg6 = null,arg7 = null,arg8 = null,arg9 = null,arg10 = null,arg11 = null):
    var args = __INTERNAL_ARGS__.new()
    args.last_is_func(
        [arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11],
        GD_.is_equal
    )

    var differences = []
    var removed = []
    var arrays := args.all as Array
    var comparator := args.last_item as Callable
    # Loop through all arrays
    for i in range(0,len(arrays)): 
        var ary = arrays[i]
        
        if not(GD_.is_array(ary)):
            gd_warn("GD_.intersection_with received a non-array type value")
            continue
        
        var added_this_iteration = []
        for item in ary:
            # See if its saved in removed, and if it is we pluck it out
            if __INTERNAL__.item_in(item,differences,comparator):
                # Item was added during this run - this means duplicate value
                # e.g. [1,2,3,1,1,1] - lets do nothing and move on
                if __INTERNAL__.item_in(item,added_this_iteration,comparator): 
                    continue
                
                pull_all_with(differences, [item], comparator)
                # Add to "deleted list" to not re-add it later via a diff array
                removed.append(item)
                continue
            elif item in removed:
                continue
            differences.append(item) 
            added_this_iteration.append(item)
                
    return differences


## Creates an array of grouped elements, the first of which contains the first elements of the 
## given arrays, the second of which contains the second elements of the given arrays, and so on.
## 
## 
## Arguments
##     [arrays] (...Array): The arrays to process.
## Returns
##      (Array): Returns the new array of grouped elements.
## Example
##      GD_.zip(['a', 'b'], [1, 2], [true, false])
##      # => [['a', 1, true], ['b', 2, false]]
## Notes
##     >> Variable Arguments
##      In js you can call an infinite amount of args using ellipses 
##      E.g. _.zip([1], [2], [3],[4],  ... , [100], [101])
##
##      But in GD_ you can call at most up to 10 args
##      E.g. GD_.zip([1], [2], [3], ... , [10])
static func zip(a:Array, b=GD_UNDEF,c=GD_UNDEF,d=GD_UNDEF,e=GD_UNDEF,f=GD_UNDEF,g=GD_UNDEF,h=GD_UNDEF,i=GD_UNDEF,j=GD_UNDEF): 
    return zip_with(a,b,c,d,e,f,g,h,i,j)


## This method is like _.fromPairs except that it accepts two arrays, one of property identifiers and one of corresponding values.
## 
## 
## Arguments
##      [props=[]] (Array): The property identifiers.
##      [values=[]] (Array): The property values.
## Returns
##      (Object): Returns the new object.
## Example
##      GD_.zip_object(['a', 'b'], [1, 2])
##      # => { 'a': 1, 'b': 2 }
## Notes
##     >> Numbers as keys
##      In js you can call an infinite amount of args using ellipses 
##      E.g. _.zip([1], [2], [3],[4],  ... , [100], [101])
##
##      But in GD_ you can call at most up to 10 args
##      E.g. GD_.zip([1], [2], [3], ... , [10])
static func zip_object(keys:Array, values:Array):
    var dict = {}
    for i in range(0, keys.size()):
        dict[keys[i]] = __INTERNAL__.get_index(values,i)
    return dict
    
## This method is like _.zipObject except that it supports property paths.
## 
## 
## Arguments
##      [props=[]] (Array): The property identifiers.
##      [values=[]] (Array): The property values.
## Returns
##      (Object): Returns the new object.
## Example
##     GD_.zip_object_deep(['a:b[0]:c', 'a:b[1]:d'], [1, 2])
##     # => { 'a': { 'b': {0:{'c':1},1:{'d':2}} } }
## Notes
##     >> Regarding integer keys
##      In js ["0", -0, 0] are "the same keys" when applied to an object
##      e.g. declaring {"0":"hello",0:"world"} in JS results in  {0:"world"}
##      But in gdscript ["0"] is a different key from [-0,0]
##      e.g. declaring {"0":"hello",0:"world"} in GODOT in {"0":"hello",0:"world"} 
##      
##      Meaning in js
##      _.zipObjectDeep( ["0"], ["foo"]) == _.zipObjectDeep( [-0],  ["foo"]) == _.zipObjectDeep( [0], ["foo"])
##      And in godot
##      _.zip_object_deep( ["0"], ["foo"]) != _.zip_object_deep( [-0],  ["foo"]) == _.zip_object_deep( [0], ["foo"])
##
##      You can specify if you want a numeric key to act as a string by wrapping
##      it in a quoate (e.g.  in th_.zip_object_deep( ["0"], ["foo"]) )
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
##      [arrays] (...Array): The arrays to process.
##      [iteratee=GD_.identity] (Function): The function to combine grouped values.
## Returns
##      (Array): Returns the new array of grouped elements.
## Example
##     var iteratee = func(a,b,c): return a + b + c
##      GD_.zip_with([1, 2], [10, 20], [100, 200], iteratee)
##      # => [111, 222]
static func zip_with(a:Array, b=GD_UNDEF,c=GD_UNDEF,d=GD_UNDEF,e=GD_UNDEF,f=GD_UNDEF,g=GD_UNDEF,h=GD_UNDEF,i=GD_UNDEF,j=GD_UNDEF): 
    var args = __INTERNAL__.to_clean_args(a,b,c,d,e,f,g,h,i,j)
    var has_callable_arg = args[-1] is Callable
    var iter_func = iteratee(args.pop_back()) if has_callable_arg else null
    
    var biggest_size = __INTERNAL__.get_max_size_of_all_arrays(args)
    var result = []
    
    for index in range(0, biggest_size):
        var arg_set = []
        
        for ary in args: # Get the current index of each array
            var size = ary.size()
            arg_set.append( null if index >= size else ary[index] )
        var slice = iter_func.callv(arg_set) if iter_func else compact(arg_set)
        result.append(slice)
    return result
            
