## @TODO Reuse tests from lodash repo
extends SimpleTest

var array = [1, 2, 3]

func it_should_take_the_first_two_elements():
    var result = GD_.take(array, 2)
    var expected = [1, 2]
    expect(result).to.equal(expected)

func it_should_treat_falsey_n_values_except_null_as_0():
    var expected = GD_.map(Utils.falsey, func (v,_v): return [1] if v == null else [])
    var actual = GD_.map(Utils.falsey, func (v,_v): return GD_.take(array, v))

    expect(actual).equal(expected)

func it_should_return_an_empty_array_when_n_less_than_1():
    var test_values = [0, -1, -INF]
    for n in test_values:
        var result = GD_.take(array, n)
        expect(result).to.equal([])

func it_should_return_all_elements_when_n_greater_or_equal_length():
    var test_values = [3, 4, 2**32, INF]
    for n in test_values:
        var result = GD_.take(array, n)
        expect(result).to.equal(array)
#
func it_should_work_as_an_iteratee_for_methods_like_map():
    var arrays = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    var actual = GD_.map(arrays, GD_.take)

    var expected = [[1], [4], [7]]
    expect(actual).to.equal(expected)
