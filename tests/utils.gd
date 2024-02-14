class_name Utils


## Used to provide falsey values to methods.
static var falsey:
	get: return {
		"zero": 0, 
		"null": null, 
		"false": false, 
		"empty string":'', 
		"empty array": []
	}
static var empties = [{},[]]
static var array: Array:
	get: return [1,2,3,4]
static var string:String:
	get: return  "1234"
static var dict:Dictionary:
	get: return {
			"dict_key_1":1,
			"dict_key_2":2,
			"dict_key_3":3,
			"dict_key_4":4
		}
static var packed_array:PackedFloat32Array: 
	get: return PackedFloat32Array([1.1,2.2,3.3,4.4])
static var node:Node:
	get:
		var n = Node.new()
		n.name = "Test Node"
		return n
static var rect2:Rect2:
	get: return Rect2(Vector2.ZERO, Vector2.ONE)
	
static var rect2i:Rect2i:
	get: return Rect2i(Vector2i.ZERO, Vector2i.ONE)
static var regex:RegEx:
	get:
		var tmp = RegEx.new()
		tmp.compile("\\w-(\\d+)")
		return tmp

enum TestEnum { 
	enum_key_1,
	enum_key_2,
	enum_key_3,
	enum_key_4,
} 
	
class TestIterator:
	var start
	var current
	var end
	var increment

	func _init(start, stop, increment):
		self.start = start
		self.current = start
		self.end = stop
		self.increment = increment

	func should_continue():
		return (current < end)

	func _iter_init(arg):
		current = start
		return should_continue()

	func _iter_next(arg):
		current += increment
		return should_continue()

	func _iter_get(arg):
		return current

static var collections = {
	'an array': ['a','b','c','d'],
	'a string': 'abcd',
	'dictionary': { "foo": "a", "bar":"b", "baz":"c", "foobarbaz":"d" },
}

static func get_last_warning(): 
	return GD_.__INTERNAL__.last_warning

static func reset_warning(): 
	GD_.__INTERNAL__.last_warning = null
	
