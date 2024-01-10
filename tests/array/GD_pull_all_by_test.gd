extends SimpleTest


func it_is_able_to_use_an_iterator_to_match_elements_to_remove():
	var array = [{ 'x': 1 }, { 'x': 2 }, { 'x': 3 }, { 'x': 1 }];
	GD_.pull_all_by(array, [{ 'x': 1 }, { 'x': 3 }], 'x');
	expect(array).to.equal([{'x':2}])
