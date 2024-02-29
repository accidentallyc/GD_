## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_can_flatten_array():
    var result = GD_.flatten([1, [2, [3, [4]], 5]])
    expect(result).to.equal([1, 2, [3, [4]], 5])
