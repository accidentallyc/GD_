## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_can_use_a_comparator_func():
	var array = [{ 'x': 1, 'y': 2 }, { 'x': 3, 'y': 4 }, { 'x': 5, 'y': 6 }];
 
	GD_.pull_all_with(array, [{ 'x': 3, 'y': 4 }], GD_.is_equal);
	expect(array).to.equal([{ 'x': 1, 'y': 2 }, { 'x': 5, 'y': 6 }])
