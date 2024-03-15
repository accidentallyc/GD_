extends SimpleTest

func it_should_return_the_symmetric_difference_of_two_arrays():
    expect(GD_.xor_with([2,1],[2,3])).to.equal([1,3])

func it_should_return_the_symmetric_difference_of_multiple_arrays():
    var actual = GD_.xor_with([2, 1], [2, 3], [3, 4])
    expect(actual).to.equal([1, 4])

    actual = GD_.xor_with([1, 2], [2, 1], [1, 2])
    expect(actual).to.equal([])

func it_should_return_an_empty_array_when_comparing_the_same_array():
    var array = [1]
    var actual = GD_.xor_with(array, array, array)

    expect(actual).to.equal([])

func it_should_return_an_array_of_unique_values():
    var actual = GD_.xor_with([1, 1, 2, 5], [2, 2, 3, 5], [3, 4, 5, 5])
    expect(actual).to.equal([1, 4])

    actual = GD_.xor_with([1, 1])
    expect(actual).to.equal([1])
    
func it_should_work_with_a_comparator():
    var a1 = ["hello","foo"]
    var a2 = ["bar","homer"]
    
    var comparator = func (a,b): return a[0] == b[0]
    var actual = GD_.xor_with(a1,a2,comparator)
    expect(actual).to.equal(["foo", "bar"])
