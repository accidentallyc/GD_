class_name Utils


## Used to provide falsey values to methods.
static var falsey = [0, null, false, '', []]
static var empties = [{},[]]


static var collections = {
	'an array': ['a','b','c','d'],
	'a string': 'abcd',
	'dictionary': { "foo": "a", "bar":"b", "baz":"c", "foobarbaz":"d" },
}

static func get_last_warning(): 
	return GD_.__INTERNAL__.last_warning

static func reset_warning(): 
	GD_.__INTERNAL__.last_warning = null
