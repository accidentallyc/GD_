extends "./GD_function.gd"

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
##      object (Object): The object to iterate over.
##      [paths] (...(string|string[])): The property paths to pick.
## Returns
##      (Array): Returns the picked values.
## Example
##      var object = { 'a': [{ 'b': { 'c': 3 } }, 4] }
##       
##      GD_.at(object, ['a[0].b.c', 'a[1]'])
##      # => [3, 4]
##
##     GD_.at(['a', 'b', 'c'], 0,2)
##     # => ['a','c']
##
## Notes
##     >> Variable Arguments
##      In js you can call an infinite amount of args using ellipses 
##      E.g. _.at([], 1,2,3,4,5,6,7,"as many as you want",10)
##
##      But in GD_ you can call at most up to 10 args
##      E.g. GD_.at([], 1,2,3,4,5,6,7,8,9)
static func at(obj, a,b=GD_UNDEF,c=GD_UNDEF,d=GD_UNDEF,e=GD_UNDEF,f=GD_UNDEF,g=GD_UNDEF,h=GD_UNDEF,i=GD_UNDEF,j=GD_UNDEF):
    return __INTERNAL__.base_at(obj, [a,b,c,d,e,f,g,h,i,j])
    

static func create(a=0, b=0, c=0): not_implemented()

static func defaults(a=0, b=0, c=0): not_implemented()

static func defaults_deep(a=0, b=0, c=0): not_implemented()

static func to_pairs(a=0, b=0, c=0): not_implemented() # alias for entries

static func to_pairs_in(a=0, b=0, c=0): not_implemented() # alias for entriesIn

## This method is like GD_.find except that it returns 
## the key of the first element predicate returns truthy for 
## instead of the element itself.
##
## Arguments
##      object (Object): The object to inspect.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (*): Returns the key of the matched element, else undefined.
## Example
##      var users = {
##          'barney':  { 'age': 36, 'active': true },
##          'fred':    { 'age': 40, 'active': false },
##          'pebbles': { 'age': 1,  'active': true }
##      }
##    
##      GD_.find_key(users, func(o, _o): return o.age < 40 )
##      ## => 'barney' (iteration order is not guaranteed)
##      
##      ## The `GD_.matches` iteratee shorthand.
##      GD_.find_key(users, { 'age': 1, 'active': true })
##      ## => 'pebbles'
##      
##      ## The `GD_.matchesProperty` iteratee shorthand.
##      GD_.find_key(users, ['active', false])
##      ## => 'fred'
##      
##      ## The `GD_.property` iteratee shorthand.
##      GD_.find_key(users, 'active')
##      ## => 'barney'
static func find_key(collection, iteratee = GD_.identity): 
    var iter_func = iteratee(iteratee)
    
    for key in keyed_iterable(collection):
        var val = collection[key]
        if iter_func.call(val,key):
            return key
            
## This method is like GD_.find_key except that it iterates over 
## elements of a collection in the opposite order.
## 
## Arguments
##      object (Object): The object to inspect.
##      [predicate=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (*): Returns the key of the matched element, else undefined.
## Example
##      var users = {
##          'barney':  { 'age': 36, 'active': true },
##          'fred':    { 'age': 40, 'active': false },
##          'pebbles': { 'age': 1,  'active': true }
##      }
##    
##      GD_.find_last_key(users, func(o, _o): return o.age < 40 )
##      ## => returns 'pebbles' assuming `GD_.find_key` returns 'barney'
##      
##      ## The `GD_.matches` iteratee shorthand.
##      GD_.find_last_key(users, { 'age': 36, 'active': true })
##      ## => 'barney'
##      
##      ## The `GD_.matchesProperty` iteratee shorthand.
##      GD_.find_last_key(users, ['active', false])
##      ## => 'fred'
##      
##      ## The `GD_.property` iteratee shorthand.
##      GD_.find_last_key(users, 'active')
##      ## => 'pebbles'
static func find_last_key(collection, iteratee = GD_.identity): 
    var tmp = keyed_iterable(collection)
    var iter_func = iteratee(iteratee)
    for i in range(tmp.size()-1,-1,-1):
        var key = tmp[i]
        var val = collection[key]
        if iter_func.call(val,key):
            return key

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
## When using string paths, delimit them with the "/" key e.g."a/b/c"
## Or use the index access notation "a['b']['c']"
##
## Arguments
##      object (Object): The object to query.
##      path (Array|string): The path of the property to get.
##      [defaultValue] (*): The value returned for null resolved values.
## Returns
##      (*): Returns the resolved value.
## Example
##      GD_.get_prop({ 'a': [{ 'b': { 'c': 3 } }] }, 'a/0/b/c')
##      # => 3
##       
##      GD_.get_prop({ 'a': [{ 'b': { 'c': 3 } }] }, ['a', 0, 'b', 'c'])
##      # => 3
##       
##      GD_.get_prop({ 'a': {}, 'a/b/c', 'default')
##      # => 'default'
##
##     GD_.get_prop([1,2,[3]], '2:1') 
##     # => 3
##
##     GD_.get_prop([ {'120':'string', 120: 'number'} ], '0[120]')
##     # => number
##
##     GD_.get_prop([ {'120':'string', 120: 'number'} ], '0['120']')
##     # => string
##
## Notes
##     >> Regarding integer keys
##      In js ["0", -0, 0] are "the same keys" when applied to an object
##      e.g. declaring {"0":"hello",0:"world"} in JS results in  {0:"world"}
##      But in gdscript ["0"] is a different key from [-0,0]
##      e.g. declaring {"0":"hello",0:"world"} in gdscript results in {"0":"hello",0:"world"} 
##      
##      Meaning in js
##      _.get( thing, "0") == _.get( thing, -0) == _.get( thing, 0)
##      And in godot
##      _.get_prop( thing, "0") != (_.get_prop( thing, -0) == _.get_prop( thing, 0))
static func get_prop(thing, path, default_value = null):
    return __INTERNAL__.base_get_prop(thing, path, default_value)
    
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

## Creates an array of values of a collection.
## 
## Arguments
##      v (Variant): The value to query.
## Returns
##      (Array): Returns the array of property values.
## Example
##      GD_.values([1,2,3,4])
##      # => [1,2,3,4]
##
##      GD_.values("1234")
##      # => ["1","2","3","4"]
##      
##      var dict = {"a":1,"b":2,"c":3,"d":4}
##      GD_.values(dict)
##      # => [1,2,3,4]
static func values(collection):
    if is_string(collection):
        return Array(collection.split())
    if is_array_like(collection):
        if not is_custom_iterator(collection):
            return Array(collection) # Converts packed arys to arrays
        #  Appending from a custom iterator is slow, so we avoid that if we can
        var ary = []
        for c in collection:
            ary.append(c)
        return ary
        
    if collection is Dictionary:
        return collection.values()
        
    gd_warn("GD_.values received a non-collection")
    return []

static func values_in(a=0, b=0, c=0): not_implemented()


