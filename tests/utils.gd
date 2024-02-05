class_name Utils


## Used to provide falsey values to methods.
static var falsey = [0, null, false, '', []]
static var empties = [{},[]]

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
	
