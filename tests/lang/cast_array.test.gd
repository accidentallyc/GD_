## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_should_cast_a_number_to_array():
    var result = GD_.cast_array(1)
    var expected = [1]
    expect(result).to.equal(expected)

func it_should_cast_an_object_to_array():
    var obj = {'a': 1}
    var result = GD_.cast_array(obj)
    var expected = [obj]
    expect(result).to.equal(expected)

func it_should_cast_a_string_to_array():
    var result = GD_.cast_array('abc')
    var expected = ['abc']
    expect(result).to.equal(expected)

func it_should_cast_null_to_array():
    var result = GD_.cast_array(null)
    var expected = [null]
    expect(result).to.equal(expected)

func it_should_cast_no_arguments_to_empty_array():
    var result = GD_.cast_array()
    var expected = []
    expect(result).to.equal(expected)

func it_should_return_same_array_if_array_passed():
    var array = [1, 2, 3]
    var result = GD_.cast_array(array)
    expect(result).to.strictly.equal(array)
