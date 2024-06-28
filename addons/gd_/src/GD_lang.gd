extends "./GD_base.gd"

## Casts value as an array if it's not one.
##
## Arguments
##      value (*): The value to inspect.
## Returns
##      (Array): Returns the cast array.
## Example
##      GD_.cast_array(1)
##      # => [1]
##       
##      GD_.cast_array({ 'a': 1 })
##      # => [{ 'a': 1 }]
##       
##      GD_.cast_array('abc')
##      # => ['abc']
##       
##      GD_.cast_array(null)
##      # => [null]
##       
##      GD_.cast_array(null)
##      # => [null]
##       
##      GD_.cast_array()
##      # => []
##       
##      var array = [1, 2, 3]
##      print(GD_.cast_array(array) == array)
##      # => true
static func cast_array(v = GD_UNDEF):
    if GD_UNDEF.is_undefined(v):
        return []
    else:
        return v if v is Array else [v]
    
## Creates a shallow clone for most values.
## Creates a good-enough clone for values that cannot be cloned 
## by conventional means.
## 
## Arguments
##      value (*): The value to clone.
## Returns
##      (*): Returns the cloned value.
## Example
##      var objects = [{ 'a': 1 }, { 'b': 2 }]
##  
##      var shallow = GD_.clone(objects)
##      console.log(shallow[0] === objects[0])
##      # true
## Notes
##     >> JS Comparison
##      In javascript, everything is an object which makes cloning relatively
##      simple, but in GDScript, some types are distinct. This makes cloning
##      a bit harder so GD_ instead is more loose on "how" a thing is cloned
##      preferring to rebuild a replica of an uncloneable class instead of
##      what would have been a "shallow" clone in js
static func clone(thing):
    if is_array(thing) \
        or thing is Dictionary \
        or has_method_safe(thing,'duplicate'):
        return thing.duplicate()
    elif is_immutable(thing):
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


## Basically a version of == that doesnt throw an error if the types
## are not matching
##
## Arguments
##      value (*): The value to compare.
##      other (*): The other value to compare.
## Returns
##      (boolean): Returns true if the values are equivalent, else false.
## Example
##      var object = { 'a': 1 };
##      var other = { 'a': 1 };
##       
##      GD_.eq(object, object);
##      # => true
##       
##      GD_.eq(object, other);
##      # => true
##       
##      GD_.eq('a', 'a');
##      # => true
##       
##      GD_.eq('a', &'a');
##      # => true
static func eq(l,r):
    if ( \
            (typeof(l) == typeof(r)) \
            or (GD_.is_number(l) and GD_.is_number(r)) \
            or (GD_.is_string(l) and GD_.is_string(r)) \
        ): 
        return l == r
    return false

## Checks if value is greater than other.
##
## Arguments
##      value (*): The value to compare.
##      other (*): The other value to compare.
## Returns
##      (boolean): Returns true if value is greater than other, else false.
## Example
##      GD_.gt(3, 1)
##      # => true
##      GD 
##      GD_.gt(3, 3)
##      # => false
##      GD 
##      GD_.gt(1, 3)
##      # => false
static func gt(a, b):
    return a > b
    
    
## Checks if value is greater than other.
##
##
## Arguments
##      value (*): The value to compare.
##      other (*): The other value to compare.
## Returns
##      (boolean): Returns true if value is greater than or equal to other, else false.
## Example
##      GD_.gte(3, 1)
##      # => true
##       
##      GD_.gte(3, 3)
##      # => true
##       
##      GD_.gte(1, 3)
##      # => false
static func gte(a,b):
    return a >= b
    
## Same as has_method but checks the type first
static func has_method_safe(o,method:String):
    return o is Object and o.has_method(method)
    
    
static func is_arguments(a=0, b=0, c=0): not_implemented()


## Checks if value is an Array or one of the PackedArray variants
##
## Arguments
##      value (*): The value to check.
## Returns
##      (boolean): Returns true if value is an array or packed array
## Example
##      GD_.is_array([1,2,3,4])
##      # => true
##
##      GD_.is_array(PackedByteArray([1,2,3,4]))
##      # => true
##       
##      GD_.is_array({1:2,3:4})
##      # => false
##       
##      GD_.is_array('abc')
##      # => false
##       
##      GD_.is_array(GD_.noop)
##      # => false
## Notes
##     >> JS Comparison
##      Theres are no "Packed" arrays in JS
static func is_array(thing, __UNUSED__ = null):
    return __INTERNAL__.base_is_array(thing, __UNUSED__)
    
static func is_array_buffer(a=0, b=0, c=0): not_implemented()

## Checks if value implements a custom iterator.
## See https://docs.godotengine.org/en/latest/tutorials/scripting/gdscript/gdscript_advanced.html#custom-iterators
##
## Arguments
##      value (*): The value to check.
## Returns
##      (boolean): Returns true if value is a custom iterator
## Example
##     class CustomIterator:  # custom iterator implementation
##
##      GD_.is_array_like(CustomIterator.new())
##      # => true
##
##      GD_.is_array([1,2,3,4])
##      # => true
## Lodash Equivalent 
##     None
static func is_custom_iterator(tmp):
    return tmp is Object and tmp.has_method('_iter_next')

## Checks if value is array-like. A value is considered 
## array-like if it can be used in a for loop.
## 
## Arguments
##     value (*): The value to check.
## Returns
##      (boolean): Returns true if value is array-like, else false.
## Example
##      GD_.is_array_like([1, 2, 3])
##      # => true
##       
##      GD_.is_array_like('abc')
##      # => true
##
##     class CustomIterator:  # custom iterator implementation
##      GD_.is_array_like(CustomIterator.new()
##      # => true
##
##      GD_.is_array_like(GD_.noop)
##     # => false
static func is_array_like(tmp): 
    return is_array(tmp) \
        or is_string(tmp) \
        or is_custom_iterator(tmp)
        
static func is_array_like_object(a=0, b=0, c=0): not_implemented()

## Checks if value is classified as a boolean
## 
## Arguments
##      value (*): The value to check.
## Returns
##      (boolean): Returns true if value is a boolean, else false.
## Example
##      GD_.is_boolean(false);
##      # => true
##       
##      GD_.is_boolean(null);
##      # => false
static func is_boolean(value, _UNUSED_ = null): 
    return typeof(value) == TYPE_BOOL

## Checks if value is classified as a boolean
## 
## Arguments
##      value (*): The value to check.
## Returns
##      (boolean): Returns true if value is a boolean, else false.
## Example
##      GD_.is_boolean(false);
##      # => true
##       
##      GD_.is_boolean(null);
##      # => false    
static func is_buffer(a=0, b=0, c=0): not_implemented()


## Checks if value is either an array, string, or dict.
## These types can be used in a for loop.
## 
## Arguments
##      value (*): The value to check.
## Returns
##      (boolean): Returns true if value is an array, string or dict.
## Example
##      GD_.is_collection("yes");
##      # => true
##      GD_.is_collection([1,2]);
##      # => true
##       
##      GD_.is_collection(null);
##      # => false    
## Lodash Equivalent 
##     None
static func is_collection(item):
    return is_array_like(item) or item is Dictionary or is_string(item)

static func is_date(a=0, b=0, c=0): not_implemented()
    
static func is_element(a=0, b=0, c=0): not_implemented()

## Checks if value is an empty object, collection, map, or set.
## 
## Objects are considered empty if they have no own enumerable string keyed properties.
## 
## Array-like values such as arguments objects, arrays, buffers, strings, or jQuery-like collections are considered empty if they have a length of 0. Similarly, maps and sets are considered empty if they have a size of 0.
## 
## Arguments
##      value (*): The value to check.
## Returns
##      (boolean): Returns true if value is empty, else false.
## Example
##      GD_.is_empty(null);
##      # => true
##       
##      GD_.is_empty(true);
##      # => true
##       
##      GD_.is_empty(1);
##      # => true
##       
##      GD_.is_empty([1, 2, 3]);
##      # => false
##       
##      GD_.is_empty({ 'a': 1 });
##      # => false
static func is_empty(value, __UNUSED__ = null):
    return size(value) <= 0

## Performs a deep comparison between two values to determine if they are equivalent.
## This equality method attempts to extract the "underlying" values of Variants
## 
## Arguments
##      value (*): The value to compare.
##      other (*): The other value to compare.
## Returns
##      (boolean): Returns true if the values are equivalent, else false.
## Example
##      GD_.is_equal(&"foobar", "foobar")
##      # => true
##       
##      is_same(&"foobar", "foobar")
##      # => false
## Notes
##      To get a "value" the method does the following:
##          • (any number type) = compare as is
##          • (string) = compare as is
##          • (string name) = cast to str
##          • (dict) = loop and compare
##          • (array-like) = loop and compare
##          • (*) = cast to str
static func is_equal(l,r): 
    # Compare basic values
    if GD_.is_number(l) and GD_.is_number(r): return l == r
    elif GD_.is_string(l) and GD_.is_string(r): return l == r
    # Loop through complex values
    elif GD_.is_array_like(l) and GD_.is_array_like(r):
        var size = GD_.size(l)
        if size != GD_.size(r): return false
        
        # If any one element is not the same we short circuit
        for i in range(0, size):
            if not is_equal(l[i],r[i]): return false
        return true
    elif l is Dictionary and r is Dictionary: 
        var size = GD_.size(l)
        if size != GD_.size(r): return false
        
        # If any one element is not the same we short circuit
        for key in l.keys():
            if not(key in r) or not( is_equal(l[key],r[key]) ): 
                return false
        return true
    
    # We cast to str for 2 reasons
    #   1: When the type is node, this gives us the node id Node<#21322>
    #   2: When the types are mismatch (float vs int) it doesnt throw an err
    return str(l) == str(r)
        
    
    
    
static func is_equal_with(a=0, b=0, c=0): not_implemented()
static func is_error(a=0, b=0, c=0): not_implemented()
#static func is_finite(a=0, b=0, c=0): not_implemented()
static func is_function(a=0, b=0, c=0): not_implemented()

## Checks if the type is a mutable or an immutable type. A type is classified
## as immutable if a completely identical value of a certain type passes the
## is_same test.
##
## Arguments
##     value (*): The value to check.
## Returns
##      (boolean): Returns true if value is immutable
## Example
##     GD_.is_immutable("foobar")
##     # => true
##
##     GD_.is_immutable([1,2,3,4])
##     # => false
## Lodash Equivalent 
##     None
static func is_immutable(thing, __UNUSED__ = null):
    var is_mutable_type = is_array(thing) \
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

## 
## Arguments
##      value (*): The value to check.
## Returns
##      (boolean): Returns true if value is a number, else false.
## Example
##      GD_.is_number(3)
##      # => true
##       
##      GD_.is_number(Number.MIN_VALUE)
##      # => true
##       
##      GD_.is_number(Infinity)
##      # => true
##       
##      GD_.is_number('3')
##      # => false
## Notes
##      To exclude Infinity, -Infinity, and NaN, which are classified 
##      as numbers, use the GD_.is_finite method.
static func is_number(a = null, _UNUSED_=null):
    return __INTERNAL__.base_is_number(a)
    
static func is_object(a=0, b=0, c=0): not_implemented()
static func is_object_like(a=0, b=0, c=0): not_implemented()

static func is_plain_object(a=0, b=0, c=0): not_implemented()

## Checks if value is classified as a RegExp object.
## 
## Since
## 0.1.0
## 
## Arguments
##      value (*): The value to check.
## Returns
##      (boolean): Returns true if value is a regexp, else false.
## Example
##      GD_.is_reg_exp(RegEx.create_from_string("\\w+"))
##      # => true
##       
##      GD_.is_reg_exp('\\w+');
##      # => false
static func is_regexp(a, _UNUSED_ = null):
    return a is RegEx
    
static func is_safe_integer(a=0, b=0, c=0): not_implemented()
static func is_set(a=0, b=0, c=0): not_implemented()

## Checks if value is classified as a String or a StringName
##
## Arguments
##      value (*): The value to check.
## Returns
##      (boolean): Returns true if value is a string, else false.
## Example
##      GD_.is_string('abc')
##      # => true
##      GD_.is_string(&'abc')
##      # => true
##      GD_.is_string(1)
##      # => false
static func is_string(thing, __UNUSED__ = null):
    return thing is String or thing is StringName
    
static func is_symbol(a=0, b=0, c=0): not_implemented()
static func is_typed_array(a=0, b=0, c=0): not_implemented()
static func is_undefined(a=0, b=0, c=0): not_implemented()
static func is_weak_map(a=0, b=0, c=0): not_implemented()
static func is_weak_set(a=0, b=0, c=0): not_implemented()

## Checks if value is less than other.
## Arguments
##      value (*): The value to compare.
##      other (*): The other value to compare.
## Returns
##      (boolean): Returns true if value is less than other, else false.
## Example
##      GD_.lt(1, 3)
##      # => true
##       
##      GD_.lt(3, 3)
##      # => false
##       
##      GD_.lt(3, 1)
##      # => false
static func lt(a, b):
    return a < b
    
static func lte(a=0, b=0, c=0):
    return a <= b
    

## Gets the size of collection by returning its length for array-like values 
## or the number of own enumerable string keyed properties for objects.
## 
##
## Arguments
##      collection (Array|Object|string): The collection to inspect.
## Returns
##     (number): Returns the collection size.
## Example
##      GD_.size([1, 2, 3])
##      # => 3
##
##      GD_.size({ 'a': 1, 'b': 2 })
##      # => 2
##
##      GD_.size('pebbles')
##      # => 7
## Notes
##     >> Collections in JS
##      In js, anything can turn to a collection as long as it has the field
##      length. In GD_, for as long as it implements length() or size() it
##      size will use that and return it
##      >> This is categorized as collection in lodash
static func size(thing, __UNUSED__ = null): 
    if is_array(thing) or thing is Dictionary:
            return thing.size()
    elif is_string(thing):
        return thing.length()
    elif thing is Object:
        if thing.has_method('length'):
            return thing.length()
        elif thing.has_method('size'):
            return thing.size()
        elif is_custom_iterator(thing):
            gd_warn("GD_.size received a custom iterator that doesnt implement size or length. This will be expensive to calculate")
            var ctr = 0
            for i in thing: 
                ctr += 1
            return ctr
    gd_warn("GD_.size received a non-collection type value")
    return 0
    
## Converts value to an array.
## Works on any collection and custom iterators
## 
## Arguments
##      value (*): The value to convert.
## Returns
##      (Array): Returns the converted array.
## Example
##      GD_.to_array({ 'a': 1, 'b': 2 });
##      # => [1, 2]
##       
##      GD_.to_array('abc');
##      # => ['a', 'b', 'c']
##       
##      GD_.to_array(1);
##      # => []
##       
##      GD_.to_array(null);
##      # => []
static func to_array(thing):
    var array = []
    if is_custom_iterator(thing):
        for i in thing:
            array.append(i)
    else:
        for key in keyed_iterable(thing):
            array.append(thing[key])
    return array
    
## Converts value to a finite number.
##
## Arguments
##      value (*): The value to convert.
## Returns
##      (number): Returns the converted number.
## Example
##      GD_.to_finite(3.2);
##      # => 3.2
##       
##      GD_.to_finite(Infinity);
##      # => 9223372036854775807
##       
##      GD_.to_finite('3.2');
##      # => 3.2
static func to_finite(value, __UNUSED__ = null): 
    if is_number(value):
        # See https://docs.godotengine.org/en/stable/classes/class_int.html
        var max_int_64 = 9223372036854775807
        if INF == value:
            return max_int_64
        elif -INF == value:
            return -max_int_64
    var result = to_number(value)
    
    if is_nan(result):
        return 0
    return to_number(value)
        
static func to_integer(a=0, b=0, c=0): not_implemented()

static func to_length(a=0, b=0, c=0): not_implemented()

## Converts value to a number.
## 
## Arguments
##      value (*): The value to process.
## Returns
##      (number): Returns the number.
## Example
##      GD_.to_number(2) # 2
##      GD_.to_number(2.2) # 2.2
##      GD_.to_number(-5) # -5
##      GD_.to_number('500') # 500
##      GD_.to_number('-3.9') # -3.9
##      GD_.to_number(&'-4.2') # -4.2
##      GD_.to_number(INF) # INF
static func to_number(value, _dummy_ = null): 
    if is_number(value):
        return value
    elif is_string(value) and value.is_valid_float():
        return float(str(value))
    return NAN
    
static func to_plain_object(a=0, b=0, c=0): not_implemented()

static func to_safe_integer(a=0, b=0, c=0): not_implemented()

#static func to_string(a=0, b=0, c=0): not_implemented()

## Lodash Equivalent 
##     None
static func keyed_iterable(thing, from_index = 0):
    if is_array_like(thing) or is_string(thing):
        var size = len(thing)
        if from_index >= 0:
            var array = range(from_index, size)
            return array
        return range(size).slice(size + from_index)
    if thing is Dictionary:
        var keys =  thing.keys()
        if from_index > 0:
            return keys.slice(from_index)
        elif from_index < 0:
            return keys.slice(thing.size() + from_index)
        else: 
            return keys
        
    gd_warn("keyed_iterable received a non-collection")
    return []
    
    
