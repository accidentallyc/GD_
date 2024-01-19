## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_should_find_the_index_of_a_value():
	var array = [1, 2, 3, 2, 5]
	var result = GD_.index_of(array, 2)
	expect(result).to.equal(1)

func it_should_return_minus_one_if_value_not_found():
	var array = [1, 2, 3, 4, 5]
	var result = GD_.index_of(array, 6)
	expect(result).to.equal(-1)

func it_should_start_searching_from_from_index():
	var array = [1, 2, 3, 2, 5]
	var result = GD_.index_of(array, 2, 2)
	expect(result).to.equal(3)

func it_should_handle_negative_from_index_as_offset_from_end():
	var array = [1, 2, 3, 2, 5]
	var result = GD_.index_of(array, 2, -3)
	expect(result).to.equal(3)

func it_should_return_minus_one_if_from_index_out_of_bounds():
	var array = [1, 2, 3, 4, 5]
	var result = GD_.index_of(array, 3, 10)
	expect(result).to.equal(-1)

func it_should_handle_large_negative_from_index_as_start_from_beginning():
	var array = [1, 2, 3, 4, 5]
	var result = GD_.index_of(array, 1, -10)
	expect(result).to.equal(0)
