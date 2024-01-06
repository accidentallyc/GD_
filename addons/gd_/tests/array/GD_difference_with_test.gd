extends SimpleTest

func it_can_use_a_comparator():
	var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }];
	 
	var eq = GD_.is_equal
	var result = GD_.difference_with(objects, [{ 'x': 1, 'y': 2 }], eq)
	
	expect(result).to.equal([{ 'x': 2, 'y': 1 }])
	
