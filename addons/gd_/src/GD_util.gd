extends "./GD_date.gd"

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
##      value (*): The value to return from the new function.
## Returns
##      (Function): Returns the new constant function.
## Example
##      var objects = GD_.map([0,0], GD_.constant({ 'a': 1 }))
##       
##      print(objects)
##      # => [{ 'a': 1 }, { 'a': 1 }]
##       
##      print(objects[0] === objects[1])
##      # => true
## 
static func constant(value = null, _UNUSED_ = null): 
    return func (a=GD_UNDEF,b=GD_UNDEF,c=GD_UNDEF,d=GD_UNDEF,e=GD_UNDEF,f=GD_UNDEF,g=GD_UNDEF,h=GD_UNDEF,i=GD_UNDEF,j=GD_UNDEF): 
        return value

## Checks value to determine whether a default value should be returned 
## in its place. The defaultValue is returned if value is NaN or null
## 
## Arguments
##      value (*): The value to check.
##      defaultValue (*): The default value.
## Returns
##      (*): Returns the resolved value.
## Example
##      GD_.default_to(1, 10)
##      # => 1
##       
##      GD_.default_to(null, 10)
##      # => 10
static func default_to(a,b): 
    match typeof(a):
        TYPE_NIL:
            return b
        TYPE_INT:
            return b if is_nan(a) else a
        TYPE_FLOAT:
            return b if is_nan(a) else a
        TYPE_OBJECT:
            return b if GD_UNDEF.is_undefined(a) or not(a) else a
    return a
    
    
static func flow(a=0, b=0, c=0): not_implemented()
static func flow_right(a=0, b=0, c=0): not_implemented()

## This method returns the first argument it receives.
## 
## Arguments
##      value (*): Any value.
## Returns
##      (*): Returns value.
## Example
##      var object = { 'a': 1 }
##  
##      print(is_same(GD_.identity(object),object))
##      # => true
static func identity(value, _unused = null): 
    return value
    
## Converts shorthands to callables for use in other funcs
##
## Arguments
##      [func=GD_.identity] (*): The value to convert to a callback.
## Returns
##      (Function): Returns the callback.
## Example
##      var users = [
##        { 'user': 'barney', 'age': 36, 'active': true },
##        { 'user': 'fred',   'age': 40, 'active': false }
##      ]
##       
##      # The `GD_.matches` iteratee shorthand.
##      GD_.filter(users, GD_.iteratee({ 'user': 'barney', 'active': true }))
##      # => [{ 'user': 'barney', 'age': 36, 'active': true }]
##       
##      # The `GD_.matches_property` iteratee shorthand.
##      GD_.filter(users, GD_.iteratee(['user', 'fred']))
##      # => [{ 'user': 'fred', 'age': 40 }]
##       
##      # The `GD_.property` iteratee shorthand.
##      GD_.map(users, GD_.iteratee('user'))
##      # => ['barney', 'fred']
static func iteratee(iteratee_val):
    return __INTERNAL__.iteratee(iteratee_val)

## Creates a function that perform a comparison between a 
## given object and source, returning true if the given object has equivalent 
## property values, else false.
##
## Arguments
##      source (Object): The object of property values to match.
## Returns
##      (Function): Returns the new spec function.
## Example
##      var objects = [
##        { 'a': 1, 'b': 2, 'c': 3 },
##        { 'a': 4, 'b': 5, 'c': 6 }
##      ]
##       
##      GD_.filter(objects, GD_.matches({ 'a': 4, 'c': 6 }))
##      # => [{ 'a': 4, 'b': 5, 'c': 6 }]
static func matches(dict:Dictionary) -> Callable:
    return __INTERNAL__.matches(dict)


## Creates a function that performs a partial deep comparison between 
## the value at path of a given object to srcValue, returning true if the 
## object value is equivalent, else false. Note: Partial comparisons will 
## match empty array and empty object srcValue values against any array 
## or object value, respectively. 
## 
## Arguments
##      path (Array|string): The path of the property to get.
##      srcValue (*): The value to match.
## Returns
##      (Function): Returns the new spec function.
## Example
##      var objects = [
##        { 'a': 1, 'b': 2, 'c': 3 },
##        { 'a': 4, 'b': 5, 'c': 6 }
##      ]
##       
##      GD_.find(objects, GD_.matches_property('a', 4))
##      # => { 'a': 4, 'b': 5, 'c': 6 }
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
##      GD_.times(2, GD_.noop)
##      # => [null, null]
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
##      path (Array|string): The path of the property to get.
## Returns
##      (Function): Returns the new accessor function.
## Example
##      var objects = [
##        { 'a': { 'b': 2 } },
##        { 'a': { 'b': 1 } }
##      ]
##       
##      GD_.map(objects, GD_.property('a:b'))
##      # => [2, 1]
## 
##     var node = Node2D.new()
##     node.global_position = Vector2(15,10)
##     var fn = GD_.property("global_position:x")
##     fn.call(node) 
##     # => 15
static func property(path):
    return __INTERNAL__.property(path)
    
        
static func property_of(a=0, b=0, c=0): not_implemented()

##  @TODO guarded method by map, every, filter, mapValues, reject, some
## static func range(a=0, b=0, c=0): not_implemented() 
## @TODO guarded method by map, every, filter, mapValues, reject, some
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
## Arguments
##      n (number): The number of times to invoke iteratee.
##      [iteratee=GD_.identity] (Function): The function invoked per iteration.
## Returns
##      (Array): Returns the array of results.
## Example
##      GD_.times(3, GD_.to_string)
##      # => ['0', '1', '2']
##       
##      GD_.times(4, func (a,b): return 0)
##      # => [0, 0, 0, 0]
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
##      [prefix=''] (string): The value to prefix the ID with.
## Returns
##      (string): Returns the unique ID.
## Example
##      GD_.unique_id('contact_')
##      # => 'contact_104'
##       
##      GD_.unique_id()
##      # => '105'
static func unique_id(prefix=&""): 
    __INTERNAL__.id_ctr += 1
    return str(prefix,__INTERNAL__.id_ctr)
