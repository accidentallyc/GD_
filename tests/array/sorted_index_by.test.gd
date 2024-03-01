## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_should_return_correct_index_for_insertion_in_sorted_array():
    var array = [{'x_value': 30}, {'x_value': 50}]
    var value = {'x_value': 40}
    var result = GD_.sorted_index_by(array, value, "x_value")
    var expected = 1  # {'x_value': 40} should be inserted at index 1
    expect(result).to.equal(expected)

func it_should_return_zero_for_insertion_before_all_elements():
    var array = [{'x_value': 10}, {'x_value': 20}, {'x_value': 30}]
    var value = {'x_value': 5}
    var result = GD_.sorted_index_by(array, value, "x_value")
    expect(result).to.equal(0)  # {'x_value': 5} should be inserted at index 0

func it_should_return_array_length_for_insertion_after_all_elements():
    var array = [{'x_value': 10}, {'x_value': 20}, {'x_value': 30}]
    var value = {'x_value': 35}
    var result = GD_.sorted_index_by(array, value, "x_value")
    expect(result).to.equal(array.size())  # {'x_value': 35} should be inserted at the end

func it_should_handle_empty_array():
    var array = []
    var value = {'x_value': 1}
    var result = GD_.sorted_index_by(array, value, "x_value")
    expect(result).to.equal(0)  # Should return 0 for an empty array

func it_should_place_value_at_start_of_duplicates():
    var array = [{'x_value': 10}, {'x_value': 20}, {'x_value': 20}, {'x_value': 30}]
    var value = {'x_value': 20}
    var result = GD_.sorted_index_by(array, value, "x_value")
    expect(result).to.equal(1)  # {'x_value': 20} should be inserted before existing 20s
