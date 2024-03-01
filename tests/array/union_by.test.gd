extends SimpleTest


func it_should_return_union_of_both_values_with_no_dupes():
    var a = [1,2,3]
    var b = [3,4,5]
    var result = GD_.union_by(a,b)
    
    expect(result).equal([1,2,3,4,5])

func it_should_dupe_base_on_iteratee():
    var a = [{"x":1},{"x":2},{"x":3}]
    var b = [{"x":3},{"x":4},{"x":5}]
    var result = GD_.union_by(a,b,"x")
    
    expect(result).equal([{"x":1},{"x":2},{"x":3},{"x":4},{"x":5}])
