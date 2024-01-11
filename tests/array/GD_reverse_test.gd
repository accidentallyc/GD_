extends SimpleTest


func it_can_reverse_an_array():
	var array = [1, 2, 3];
	GD_.reverse(array);

	expect(array).to.equal([3, 2, 1])
