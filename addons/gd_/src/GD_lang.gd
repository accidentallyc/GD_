extends "./GD_base.gd"

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
static func is_array(thing, __UNUSED__ = null):
    return __INTERNAL__.is_array(thing, __UNUSED__)
    
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
    return __INTERNAL__.is_empty(value, __UNUSED__)

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
## Notes
##      To exclude Infinity, -Infinity, and NaN, which are classified 
##      as numbers, use the GD_.is_finite method.
static func is_number(a = null, _UNUSED_=null):
    return __INTERNAL__.is_number(a)
    
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
static func is_string(thing, __UNUSED__ = null):
    return __INTERNAL__.is_string(thing, __UNUSED__)
    
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
    return __INTERNAL__.to_finite(value, __UNUSED__)
        
static func to_integer(a=0, b=0, c=0): not_implemented()

static func to_length(a=0, b=0, c=0): not_implemented()

static func to_number(value): 
    if __INTERNAL__.is_number(value):
        return value
    elif GD_.is_string(value) and value.is_valid_float():
        return float(str(value))
    return NAN
    
static func to_plain_object(a=0, b=0, c=0): not_implemented()

static func to_safe_integer(a=0, b=0, c=0): not_implemented()

#static func to_string(a=0, b=0, c=0): not_implemented()
