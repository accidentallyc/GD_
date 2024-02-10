# GD_ (_100/289_ implemented)

**Wanna jump into it? See [the api docs](https://accidentallyc.github.io/GD_/)**

**Visit it in the [asset library](https://godotengine.org/asset-library/asset/2486)**

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

GD_.get_prop(everything_everywhere_all_at_once, "array:1:global_position:y")
# => 123
```

## 2 Ways to install

* Install it through the [asset library](https://godotengine.org/asset-library/asset/2486)
* Copy `addons\GD_.gd` and `addons\GD_base.gd` to your project
  * _note_: these 2 must be in the same folder


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

See [the api readme](https://github.com/accidentallyc/GD_/blob/master/api.md)


**Contributing**

Just do a pull request with the following requirements
1. Add a unit test node for it at `res://tests/unit_tests.tscn` scene
1. Update the comments, it should match how the other comments are written because  👇
1. Run the auto-markdown generator at `scripts/rebuild_webdocs.gd` which autogenerates api.md
