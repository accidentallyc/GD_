extends "./GD_object.gd"


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
##      collection (Array|Object): The collection to iterate over.
##      [iteratee=GD_.identity] (Function): The iteratee to transform keys.
## Returns
##      (Object): Returns the composed aggregate object.
## Example
##      GD_.count_by([6.1, 4.2, 6.3], GD_.floor)
##      # => { '4': 1, '6': 2 }
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.count_by(['one', 'two', 'three'], 'length')
##      # => { '3': 2, '5': 1 }
static func count_by(collection, iteratee = null):
    if not(super.is_collection(collection)):
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
##      GD_.each
## Arguments
##      collection (Array|Object): The collection to iterate over.
##      [iteratee=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (*): Returns collection.
## Example
##      GD_.for_each([1, 2], func (value,_index): print(value))
##      # => Logs `1` then `2`.
##       
##      GD_.for_each({ 'a': 1, 'b': 2 }, func (_value, key): print(key))
##      # => Logs 'a' then 'b' (iteration order is not guaranteed).
static func for_each(collection, iteratee): 
    if not(super.is_collection(collection)):
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
##      collection (Array|Object): The collection to iterate over.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (boolean): Returns true if all elements pass the predicate check, else false.
## Example
##      GD_.every([true, 1, null, 'yes'])
##      # => false
##       
##      var users = [
##        { 'user': 'barney', 'age': 36, 'active': false },
##        { 'user': 'fred',   'age': 40, 'active': false }
##      ]
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.every(users, { 'user': 'barney', 'active': false })
##      # => false
##       
##      # The `GD_.matchesProperty` iteratee shorthand.
##      GD_.every(users, ['active', false])
##      # => true
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.every(users, 'active')
##      # => false
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
##      collection (Array|Object): The collection to iterate over.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (Array): Returns the new filtered array.
## Example
##      var users = [
##        { 'user': 'barney', 'age': 36, 'active': true },
##        { 'user': 'fred',   'age': 40, 'active': false }
##      ]
##       
##      GD_.filter(users, func(o,_index): return !o.active)
##      # => objects for ['fred']
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.filter(users, { 'age': 36, 'active': true })
##      # => objects for ['barney']
##       
##      # The `GD_.matches_property` iteratee shorthand.
##      GD_.filter(users, ['active', false])
##      # => objects for ['fred']
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.filter(users, 'active')
##      # => objects for ['barney']
static func filter(collection, iteratee = GD_UNDEF):
    if not(super.is_collection(collection)):
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
##      collection (Array|Object): The collection to inspect.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
##      [fromIndex=0] (number): The index to search from.
## Returns
##      (*): Returns the matched element, else null.
## Example
##      var users = [
##        { 'user': 'barney',  'age': 36, 'active': true },
##        { 'user': 'fred',    'age': 40, 'active': false },
##        { 'user': 'pebbles', 'age': 1,  'active': true }
##      ]
##  
##      GD_.find(users, func(o,_index): return o.age < 40)
##      # => object for 'barney'
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.find(users, { 'age': 1, 'active': true })
##      # => object for 'pebbles'
##       
##      # The `GD_.matches_property` iteratee shorthand.
##      GD_.find(users, ['active', false])
##      # => object for 'fred'
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.find(users, 'active')
##      # => object for 'barney'
static func find(collection, iteratee = null, from_index = 0):
    if not(super.is_collection(collection)):
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
##      collection (Array|Object): The collection to iterate over.
##      [iteratee=GD_.identity] (Function): The iteratee to transform keys.
## Returns
##      (Object): Returns the composed aggregate object.
## Example
##      GD_.group_by([6.1, 4.2, 6.3], GD_.floor)
##      # => { '4': [4.2], '6': [6.1, 6.3] }
##       
##      # The `_.property` iteratee shorthand.
##      GD_.group_by(['one', 'two', 'three'], 'length')
##      # => { '3': ['one', 'two'], '5': ['three'] }
static func group_by(collection, iteratee = GD_.identity):
    if not(super.is_collection(collection)):
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
##      collection (Array|Object|string): The collection to inspect.
##      value (*): The value to search for.
##      [fromIndex=0] (number): The index to search from.
## 	Returns
##      (boolean): Returns true if value is found, else false.
## Example
##      GD_.includes([1, 2, 3], 1)
##      # => true
##       
##      GD_.includes([1, 2, 3], 1, 2)
##      # => false
##       
##      GD_.includes({ 'a': 1, 'b': 2 }, 1)
##      # => true
##       
##      GD_.includes('abcd', 'bc')
##      # => true
static func includes(collection, thing, from_index :=0):
    if super.is_collection(collection):
        for key in keyed_iterable(collection,from_index):
            if eq(collection[key], thing): 
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
##      collection (Array|Object): The collection to iterate over.
##      [iteratee=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (Array): Returns the new mapped array.
## Example
##      func square(n, _index): return n * n
##  
##      GD_.map([4, 8], square)
##      # => [16, 64]
##       
##      GD_.map({ 'a': 4, 'b': 8 }, square)
##      # => [16, 64] (iteration order is not guaranteed)
##       
##      var users = [
##        { 'user': 'barney' },
##        { 'user': 'fred' }
##      ]
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.map(users, 'user')
##      # => ['barney', 'fred']
static func map(collection, iteratee = GD_.identity):
    if not(super.is_collection(collection)):
        gd_warn("GD_.map received a non-collection type value")
        return null
        
    var iter_func = super.iteratee(iteratee)
        
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
##      collection (Array|Object): The collection to iterate over.
##      [iteratee=GD_.identity] (Function): The function invoked per iteration.
##      [accumulator] (*): The initial value.
## Returns
##      (*): Returns the accumulated value.
## Example
##      var sum = func (accum, kv): return accum + kv.value
##      GD_.reduce([1, 2], sum, 0)
##      # => 3
##  	
##     var cb = func (result, kv):
##        (result[kv.value] || (result[kv.value] = [])).push(kv.key)
##        return result
##      
##      GD_.reduce({ 'a': 1, 'b': 2, 'c': 1 }, cb, {})
##      # => { '1': ['a', 'c'], '2': ['b'] } (iteration order is not guaranteed)
## Notes
##     >> Callable Signature
##      In GD_ we try to standardize callbacks into having 2 arguments
##      So they can be chained together. Thats why we pass a dictionary down
##       instead
static func reduce(collection, iteratee = GD_.identity, accumulator = null):
    if not super.is_collection(collection):
        return null
    
    var iter_func = iteratee(iteratee)
    
    var iterable = keyed_iterable(collection)
    var starting_index = 0
    if accumulator == null:
        starting_index = 1
        var key = iterable[0]
        accumulator = collection[key]
    var kv_tmp =  {"key":null,"value":null}
    for key_index in range(starting_index, super.size(iterable)):
        kv_tmp.key = iterable[key_index]
        kv_tmp.value = collection[kv_tmp.key]
        accumulator = iter_func.call(accumulator, kv_tmp)
    
    return accumulator
        

## This method is like GD_.reduce except that it iterates over elements 
## of collection from right to left.
## 
## 
## Arguments
##      collection (Array|Object): The collection to iterate over.
##      [iteratee=GD_.identity] (Function): The function invoked per iteration.
##      [accumulator] (*): The initial value.
## Returns
##      (*): Returns the accumulated value.
## Example
##      var array = [[0, 1], [2, 3], [4, 5]]
##       
##     var concat = func (flattened, kv): flattened.append_array(kv.value)
##      GD_.reduce_right(array, concat, [])
##      # => [4, 5, 2, 3, 0, 1]
static func reduce_right(collection, iteratee = GD_.identity, accumulator = null):
    if not super.is_collection(collection):
        return null
        
    var iter_func = iteratee(iteratee)
    var iterable = keyed_iterable(collection)
    
    for key_index in range(super.size(iterable) - 1, -1, -1):
        var key = iterable[key_index]
        var value = collection[key]
    
    var starting_index = super.size(iterable) - 1
    
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
##      collection (Array|Object): The collection to iterate over.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (Array): Returns the new filtered array.
## Example
##      var users = [
##        { 'user': 'barney', 'age': 36, 'active': false },
##        { 'user': 'fred',   'age': 40, 'active': true }
##      ]
##     var not_active = func (o, i): 
##      return !o.active
##
##      GD_.reject(users, function(o) { return !o.active })
##      # => objects for ['fred']
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.reject(users, { 'age': 40, 'active': true })
##      # => objects for ['barney']
##       
##      # The `GD_.matchesProperty` iteratee shorthand.
##      GD_.reject(users, ['active', false])
##      # => objects for ['fred']
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.reject(users, 'active')
##      # => objects for ['barney']
static func reject(collection, callable = identity): 
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

## Creates an array of shuffled values, using a version of the Fisher-Yates shuffle.
## This version can be used on any collection.
## Arguments
##      collection (Array|Object): The collection to shuffle.
## Returns
##      (Array): Returns the new shuffled array.
## Example
##      GD_.shuffle([1, 2, 3, 4]);
##      # => [4, 1, 3, 2]
##      
##      GD_.shuffle("1234")
##      # => [4, 1, 3, 2]
##
##      GD_.shuffle({"red":1,"green":2,"blue":3,"indigo":4})
##      # => ["green","indigo","blue","red"]
static func shuffle(collection, _UNUSED_ = null):
    if collection is Array:
        # Use built in function
        var dup = collection.duplicate()
        dup.shuffle()
        return dup
    elif super.is_custom_iterator(collection):
        collection = super.to_array(collection)
    
    # Fallback to manual implementation
    var keys = keyed_iterable(collection)
    var new_array = []
    var i = super.size(keys)
    var array = []
    
    while i != 0:
        var random_index = randi() % i
        i -= 1
        new_array.append(collection[keys[random_index]])
        keys.erase(keys[random_index])
        
    return new_array


## Checks if predicate returns truthy for any element of collection. 
## Iteration is stopped once predicate returns truthy. 
## The predicate is invoked with two arguments: (value, index|key).
##
## Arguments
##      collection (Array|Dictionary|String): The collection to iterate over.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (boolean): Returns true if any element passes the predicate check, else false.
## Example
##      GD_.some([null, 0, 'yes', false], Boolean)
##      # => true
##       
##      var users = [
##        { 'user': 'barney', 'active': true },
##        { 'user': 'fred',   'active': false }
##      ]
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.some(users, { 'user': 'barney', 'active': false })
##      # => false
##       
##      # The `GD_.matches_property` iteratee shorthand.
##      GD_.some(users, ['active', false])
##      # => true
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.some(users, 'active')
##      # => true
## Notes
##     >> @TODO guarded method by map, every, filter, mapValues, reject, some
static func some(collection, iteratee = null): 
    if not(super.is_collection(collection)):
        gd_warn("GD_.some received a non-collection type value")
        return null
        
    var iter_func = iteratee(iteratee)
    for key in keyed_iterable(collection):
        if iter_func.call(collection[key],key):
            return true
    return false
    
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func sort_by(a=0, b=0, c=0): not_implemented() 
