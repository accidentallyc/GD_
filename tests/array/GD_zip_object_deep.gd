extends SimpleTest

	
func it_is_able_to_set_deep_property_of_object():
	var result = GD_.zip_object_deep(['a:b[0]:c', 'a:b[1]:d'], [1, 2]);
	var expected = { 'a': { 'b': {0:{'c':1},1:{'d':2}} } }
	
	expect(result).equal(expected)
