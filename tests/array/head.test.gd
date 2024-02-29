## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_should_return_first_element_of_non_empty_array():
    var array = [1, 2, 3]
    var result = GD_.head(array)
    expect(result).to.equal(1)

func it_should_return_null_for_empty_array():
    var array = []
    var result = GD_.head(array)
    expect(result).to.equal(null)
