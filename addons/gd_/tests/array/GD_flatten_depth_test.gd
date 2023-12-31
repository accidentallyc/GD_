extends SimpleTest

var array = [1, [2, [3, [4]], 5]];
func it_should_flatten_array_to_specified_depth():
	var flattened = GD_.flatten_depth(array, 2)
	var expected = [1, 2, 3, [4], 5]
	expect(flattened).to.equal(expected)

func it_should_not_flatten_beyond_array_depth():
	var flattened = GD_.flatten_depth(array, 10)
	var expected = [1, 2, 3, 4, 5]
	expect(flattened).to.equal(expected)

func it_should_leave_array_unchanged_if_depth_is_zero():
	var flattened = GD_.flatten_depth(array, 0)
	var expected = [1, [2, [3, [4]], 5]]
	expect(flattened).to.equal(expected)
