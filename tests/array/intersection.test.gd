## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_should_return_common_elements():
    var array1 = [1, 2, 3]
    var array2 = [2, 3, 4]
    var result = GD_.intersection(array1, array2)
    var expected = [2, 3]
    expect(result).to.equal(expected)


func it_should_return_empty_array_when_no_common_elements():
    var array1 = [1, 2, 3]
    var array2 = [4, 5, 6]
    var result = GD_.intersection(array1, array2)
    expect(result).to.equal([])


func it_should_handle_repeating_elements():
    var array1 = [1, 2, 2, 3]
    var array2 = [2, 2, 3, 4]
    var result = GD_.intersection(array1, array2)
    var expected = [2, 3]  # Assuming your function does not include duplicates
    expect(result).to.equal(expected)


func it_should_handle_empty_arrays():
    var array1 = []
    var array2 = [1, 2, 3]
    var result = GD_.intersection(array1, array2)
    expect(result).to.equal([])


func it_should_handle_multiple_arrays():
    var array1 = [1, 2, 3]
    var array2 = [2, 3, 4]
    var array3 = [3, 4, 5]
    var result = GD_.intersection(array1, array2, array3)
    var expected = [3]
    expect(result).to.equal(expected)
    
func it_should_handle_oddly_numbered_arrays():
    var array1 = [1, 2, 3]
    var array2 = [2, 3, 4]
    var array3 = [10,9,8,7,6,5,4,3]
    var result = GD_.intersection(array1, array2, array3)
    var expected = [3]
    expect(result).to.equal(expected)
    
func it_should_handle_more_than_2_arrays_but_1_contains_no_results():
    var array1 = [1, 2, 3]
    var array2 = [2, 3, 4]
    var array3 = [7]
    var result = GD_.intersection(array1, array2, array3)
    var expected = []
    expect(result).to.equal(expected)
