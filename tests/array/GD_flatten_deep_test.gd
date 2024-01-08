extends SimpleTest


func it_can_flatten_array():
	var result = GD_.flatten_deep([1, [2, [3, [4]], 5]])
	expect(result).to.equal( [1, 2, 3, 4, 5])
