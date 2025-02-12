# GD_ (_123/289_ implemented) +6 godot specific

**Wanna jump into it? See [the api docs](https://accidentallyc.github.io/GD_/)**

**Visit it in the [asset library](https://godotengine.org/asset-library/asset/2486)**

GD_ is an effort to bring [Lodash](https://lodash.com/) into Godot. 
This will attempt to replicate Lodash's behavior as close as possible (even if the implementation becomes round about).

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

GD_.get_prop(everything_everywhere_all_at_once, "array:1:global_position:y")
# => 123
```

## 2 Ways to install

* Install it through the [asset library](https://godotengine.org/asset-library/asset/2486)
* Copy `addons\gd_\src` folder into your project and it must contain the following files
	* GD_.gd
	* GD_array.gd
	* GD_collection.gd
	* GD_object.gd
	* GD_function.gd
	* GD_math.gd
	* GD_number.gd
	* GD_util.gd
	* GD_date.gd
	* GD_string.gd
	* GD_lang.gd
	* GD_base.gd


## Special callouts

### Regarding callables and callbacks

*In version 4.3 and above*
> callbacks can be of variable length, and GD_ ensures that all Callables
> will be called irregardless of how many arguments are actually needed

```gdscript
# Version 4.3 and above, all of these work

GD_.drop_right_while(..., func(): return true)
GD_.drop_right_while(..., func(value): return true)
GD_.drop_right_while(..., func(value,index): return true)
GD_.drop_right_while(..., func(value,index,array): return true)
```

*In version 4.2 and below*
> all Callables supplied should **always be constructed with 2 arguments.**
> This means that if in lodash you have a callback like in `_.drop_right_while`
> which is invoked with 3 arguments (value,index,array). We drop the 3rd arguments.
> all callbacks in 4.2 accept at least 2, the second one sometimes being a dummy

```gdscript
# Version 4.2, only the callable below with 2 args works
GD_.drop_right_while(..., func(value,index): return true)

# the rest of these will not work
GD_.drop_right_while(..., func(): return true)
GD_.drop_right_while(..., func(value): return true)
GD_.drop_right_while(..., func(value,index,array): return true)
```

### Regarding equality

Some functions specifically use [SameValueZero](https://262.ecma-international.org/7.0/#sec-samevaluezero) specification for equality. 
For GD_ we just use Godot's `==` operator which for the most part behaves like the [SameValueZero](https://262.ecma-international.org/7.0/#sec-samevaluezero).

@TODO tabulate differences

## Requests 

This project is very much in its early stages, so it's very likely for the function you need to not exist yet. If that happens, please leave an issue for a specific function to be prioritized.


## Documentation for existing functions

**Wanna jump into it? See [the api docs](https://accidentallyc.github.io/GD_/)**


**Contributing**

Just do a pull request against `develop` with the following requirements
1. Determine what category the function belongs to (array, collection, etc).
1. Then add your code to the corresponding category file (GD_array.gd, GD_collection.gd, etc)
1. Add a unit test node for it at `res://tests/unit_tests.tscn` scene
	1. For unit tests I suggest checking the test cases over at [Lodash's repo](https://github.com/lodash/lodash/tree/main/test)
1. Update the comments, it should match how the other comments are written because  👇
1. Run the auto-markdown generator at `scripts/rebuild_webdocs.gd` which autogenerates index.html
1. Once your PR is merged into develop, I will bump up the plugin version and deploy to the asset library
