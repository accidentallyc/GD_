## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_can_return_unique_array_using_a_custom_comparator():
	var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }, { 'x': 1, 'y': 2 }]
 
	var results = GD_.uniq_with(objects, GD_.is_equal);
	expect(results).to.equal([{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }])
