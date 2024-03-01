extends SimpleTest

func it_should_return_union_of_both_values_with_no_dupes():
    var a = [1,2,3]
    var b = [3,4,5]
    var result = GD_.union(a,b)
    
    expect(result).equal([1,2,3,4,5])


func it_should_accept_multiple_arguments():
    var result = GD_.union([1],[2],[3],[4],[5])
    
    expect(result).equal([1,2,3,4,5])
