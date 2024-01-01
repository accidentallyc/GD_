extends SimpleTest


func it_should_intersect_based_on_math_floor():
	expect(GD_.intersection_by([2.1, 1.2], [2.3, 3.4], GD_.floor)).to.equal([2.1])


func it_should_intersect_based_on_property_shorthand():
	var array1 = [{'x': 1}]
	var array2 = [{'x': 2}, {'x': 1}]
	var result = GD_.intersection_by(array1, array2, "x")
	var expected = [{'x': 1}]
	expect(result).to.equal(expected)


func it_should_intersect_based_on_matches_property_shorthand():
	var array1 = [{'type': 'fruit', 'name': 'apple'}, {'type': 'vegetable', 'name': 'carrot'}]
	var array2 = [{'type': 'fruit', 'name': 'banana'}, {'type': 'fruit', 'name': 'apple'}]
	var result = GD_.intersection_by(array1, array2, ["type", "fruit"])
	var expected = [{'type': 'fruit', 'name': 'apple'}]
	expect(result).to.equal(expected)


func it_should_intersect_based_on_matches_shorthand():
	var criteria = {'type': 'fruit'}
	var array1 = [{'type': 'fruit', 'name': 'apple'}, {'type': 'vegetable', 'name': 'carrot'}]
	var array2 = [{'type': 'fruit', 'name': 'banana'}, {'type': 'fruit', 'name': 'apple'}]
	var result = GD_.intersection_by(array1, array2, criteria)
	var expected = [{'type': 'fruit', 'name': 'apple'}]
	expect(result).to.equal(expected)
