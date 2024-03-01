## @TODO Reuse tests from lodash repo
extends SimpleTest

var comparator = GD_.is_equal
func it_should_return_intersection_using_default_equal_compareator():
    expect(GD_.intersection_with([2,1],[1,2]))


func it_should_return_intersection_based_on_comparator():
    var array1 = [1, 2, 3]
    var array2 = [2, 3, 4]
    var result = GD_.intersection_with(array1, array2, comparator)
    var expected = [2, 3]
    expect(result).to.equal(expected)


func it_should_return_empty_array_for_no_intersection():
    var array1 = [1, 2, 3]
    var array2 = [4, 5, 6]
    var result = GD_.intersection_with(array1, array2, comparator)
    expect(result).to.equal([])


func it_should_handle_intersection_with_duplicates():
    var array1 = [1, 2, 2, 3]
    var array2 = [2, 2, 4, 5]
    var result = GD_.intersection_with(array1, array2, comparator)
    var expected = [2]
    expect(result).to.equal(expected)


func it_should_handle_empty_arrays():
    var array1 = []
    var array2 = [1, 2, 3]
    var result = GD_.intersection_with(array1, array2, comparator)
    expect(result).to.equal([])


func it_should_work_with_custom_comparator():
    """
    Note on this test: Yes this is a weird comparator and its an edge case
    But it matches what lodash would return
    """
    var custom_comparator = func (a, b): return a < b
    var array1 = [1, 3, 5]
    var array2 = [4]
    var result = GD_.intersection_with(array1, array2, custom_comparator)
    var expected = [1, 3]
    expect(result).to.equal(expected)
