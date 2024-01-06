extends SimpleTest

func it_should_fill_entire_array_by_mutation():
	var array = [1, 2, 3]
	GD_.fill(array, 'a')
	var expected = ['a', 'a', 'a']
	expect(array).to.equal(expected)

func it_should_fill_new_array_with_specified_value():
	var array = [1, 2, 3]
	GD_.fill(array, 2)
	var expected = [2, 2, 2]
	expect(array).to.equal(expected)

func it_should_fill_array_with_value_from_start_to_end():
	var array = [4, 6, 8, 10]
	GD_.fill(array, '*', 1, 3)
	var expected = [4, '*', '*', 10]
	expect(array).to.equal(expected)
