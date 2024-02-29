## @TODO Reuse tests from lodash repo
extends SimpleTest

var array = [1, 1, 2]


func it_can_return_a_duplicate_free_array():
    var result = GD_.sorted_uniq([1, 1, 2]);
    expect(result).to.equal([1, 2])
    expect(result).to.strictly.NOT.equal(array)
