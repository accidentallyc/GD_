# GD_ (_50 of 272_ implemented)

GD_ is an effort to bring [Lodash](https://lodash.com/) into Godot. This will attempt to replicate Lodash's behavior as close as possible (even if the implementation becomes round about).

```gdscript
# Map Example
var users = [
    { 'user': 'barney' },
    { 'user': 'fred' }
]; 		 


GD_.map(users, 'user');  
# =>  ['barney', 'fred']

# Get Example
var node = Node2D.new()
node.global_position = Vector2(999,123)

var everything_everywhere_all_at_once = {
    "array": ["hello", node, "world"]
}

GD_.get(everything_everywhere_all_at_once, "array:1:global_position:y")
# => 123
```

## Special callouts

### Regarding callables and callbacks

Because of the way GDScript treats callables, 
> all callbacks should **always be constructed with 2 arguments.**


This means that if in lodash you have a callback like in `_.drop_right_while`
which is invoked with 3 arguments (value,index,array). We drop the 3rd arguments.

```gdscript
var callback_2_args = func (value, index): 
    return value

GD_.drop_right_while(..., callback_2_args)
```

This also means that if in lodash a callback is invoked with only 1 argument like in `_.differenceBy`, we must supply a dummy arg.

```
var callback_1_arg =  func (value, _unused): 
    return value

GD_.difference_by(..., callback_1_arg)
```

### Regarding equality

Some functions specifically use [SameValueZero](https://262.ecma-international.org/7.0/#sec-samevaluezero) specification for equality. 
For GD_ we just use Godot's `==` operator which for the most part behaves like the [SameValueZero](https://262.ecma-international.org/7.0/#sec-samevaluezero).

@TODO tabulate differences

## Requests 

This project is very much in its early stages, so it's very likely for the function you need to not exist yet. If that happens, please leave an issue for a specific function to be prioritized.


## Documentation for existing functions

### `GD_.chunk(array:Array,size=1)`
Creates an array of elements split into groups the length of size. 
If array can't be split evenly, the final chunk will be the remaining elements.
This attempts to replicate lodash's chunk. 
https://lodash.com/docs/4.17.15#chunk

#### Arguments
* array (Array): The array to process.
* [size=1] (number): The length of each chunk
#### Returns
* (Array): Returns the new array of chunks.

```gdscript
GD_.chunk(['a', 'b', 'c', 'd'], 2);
# => [['a', 'b'], ['c', 'd']]
 
GD_.chunk(['a', 'b', 'c', 'd'], 3);
# => [['a', 'b', 'c'], ['d']]
```

### `GD_.compact(array:Array)`
Creates an array with all falsey values removed. 
The falsiness is determined by a basic if statement.
The values false, null, 0, "", [], and {} are falsey.
This attempts to replicate lodash's compact. 
https://lodash.com/docs/4.17.15#compact

#### Arguments
* array (Array): The array to compact.
#### Returns
* (Array): Returns the new array of filtered values.

```gdscript
GD_.compact([0, 1, false, 2, '', 3]);
# => [1, 2, 3]
```

### `GD_.concat(array:Array, a=_NULL_ARG_, ..., k=_NULL_ARG_)`
Creates a new array concatenating array with any additional arrays and/or values.
This attempts to replicate lodash's concat. 
This func can receive up to 10 concat values. Hopefully thats enough
This attempts to replicate lodash's concat.
https://lodash.com/docs/4.17.15#concat

#### Arguments
* array (Array): The array to concatenate.
* [values] (...*): The values to concatenate.
#### Returns
* (Array): Returns the new concatenated array.


```gdscript
var array = [1];
var other = GD_.concat(array, 2, [3], [[4]]);
 
console.log(other);
# => [1, 2, 3, [4]]
 
console.log(array);
# => [1]
```

## `GD_.difference(array_left:Array, array_right:Array)`
Creates an array of array values not included in the other given arrays 
using == for comparisons. The order and references of result values 
are determined by the first array.
This attempts to replicate lodash's difference.
https://lodash.com/docs/4.17.15#difference


##### Arguments
* array (Array): The array to inspect.
* [values] (...Array): The values to exclude.
#### Returns
* (Array): Returns the new array of filtered values.

```gdscript
GD_.difference([2, 1], [2, 3]);
# => [1]
```

## `GD_.difference_by(array_left, array_right, iteratee = GD_.identity)`
This method is like GD_.difference except that it accepts iteratee which 
is invoked for each element of array and values to generate the criterion 
by which they're compared using ==. The order and references of result 
values are determined by the first array. The iteratee is 
invoked with one argument: (value)
This attempts to replicate lodash's differenceBy.
https://lodash.com/docs/4.17.15#differenceBy

### Arguments
* array (Array): The array to inspect.
* [values] (...Array): The values to exclude.
* [iteratee=_.identity] (Function): The iteratee invoked per element.
### Returns
* (Array): Returns the new array of filtered values.

```gdscript
GD_.difference_by([2.1, 1.2], [2.3, 3.4], GD_.floor);
# => [1.2]
 
# The `GD_.property` iteratee shorthand.
GD_.difference_by([{ 'x': 2 }, { 'x': 1 }], [{ 'x': 1 }], 'x');
# => [{ 'x': 2 }]
```

## TODO


Pending functions 

> pull_all_by,
pull_all_with,
pull_at,
remove,
reverse,
slice,
sorted_index,
sorted_index_by,
sorted_index_of,
sorted_last_index,
sorted_last_index_by,
sorted_last_index_of,
sorted_uniq,
sorted_uniq_by,
tail,
take,
take_right,
take_right_while,
take_while,
union,
union_by,
union_with,
uniq,
uniq_by,
uniq_with,
unzip,
unzip_with,
without,
xor,
xor_by,
xor_with,
zip,
zip_object,
zip_object_deep,
zip_with,
each_right,
every,
find_last,
flat_map,
flat_map_deep,
flat_map_depth,
for_each_right,
includes,
invoke_map,
key_by,
order_by,
partition,
reduce,
reduce_right,
reject,
sample,
sample_size,
shuffle,
size,
sort_by,
now,
after,
ary,
before,
bind,
bind_key,
curry,
curry_right,
debounce,
defer,
delay,
flip,
memoize,
negate,
once,
over_args,
partial,
partial_right,
rearg,
rest,
spread,
throttle,
unary,
wrap_func,
clone,
clone_deep,
clone_deep_with,
clone_with,
conforms_to,
eq,
gt,
gte,
is_arguments,
is_array,
is_array_buffer,
is_array_like,
is_array_like_object,
is_boolean,
is_buffer,
is_date,
is_element,
is_empty,
is_equal_with,
is_error,
is_finite,
is_function,
is_integer,
is_length,
is_map,
is_match,
is_match_with,
is_nan,
is_native,
is_nil,
is_null,
is_number,
is_object,
is_object_like,
is_plain_object,
is_reg_exp,
is_safe_integer,
is_set,
is_string,
is_symbol,
is_typed_array,
is_undefined,
is_weak_map,
is_weak_set,
lt,
lte,
to_array,
to_finite,
to_integer,
to_length,
to_number,
to_plain_object,
to_safe_integer,
to_string,
add,
ceil,
divide,
max,
max_by,
mean,
mean_by,
min,
min_by,
multiply,
round,
subtract,
sum,
sum_by,
clamp,
in_range,
random,
assign,
assign_in,
assign_in_with,
assign_with,
at,
create,
defaults,
defaults_deep,
to_pairs,
to_pairs_in,
find_key,
find_last_key,
for_in,
for_in_right,
for_own,
for_own_right,
functions,
functions_in,
get,
has,
has_in,
invert,
invert_by,
invoke,
keys,
keys_in,
map_keys,
map_values,
merge,
merge_with,
omit,
omit_by,
pick,
pick_by,
result,
set,
set_with,
to_pairs,
to_pairs_in,
transform,
unset,
update,
update_with,
values,
values_in,
attempt,
bind_all,
cond,
conforms,
constant,
flow,
flow_right,
method,
method_of,
mixin,
no_conflict,
nth_arg,
over,
over_every,
over_some,
property_of,
range,
range_right,
run_in_context,
stub_array,
stub_false,
stub_object,
stub_string,
stub_true,
times,
to_path,
unique_id


**Contributing**

Just do a pull request with the following requirements
1. Add a unit test node for it at `res://addons/gd_/tests/unit_tests.tscn` scene
1. Update the comment to reflect the lodash documentation
1. Update this README.MD
    1. Add an entry to the documentation list
    1. Pop the function off the TODO
    1. Update the tracking count