extends SimpleTest

var array = [1, 2, 3]

func it_should_exclude_the_first_element():
	expect(GD_.tail(array)).to.equal([2, 3])

func it_should_return_an_empty_when_querying_empty_arrays():
	expect(GD_.tail([])).to.equal([])

func it_should_work_as_an_iteratee_for_methods_like_map():
	const array = [
		[1, 2, 3],
		[4, 5, 6],
		[7, 8, 9],
	]
	
	var actual = GD_.map(array, GD_.tail)

	expect(actual).to.equal([
		[2, 3],
		[5, 6],
		[8, 9],
	])
