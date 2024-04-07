extends SimpleTest

var array = [1, 2, 3, 4];

func should_take_elements_while_predicate_returns_truthy():
    var t1 = 0
    var t2 = 0
    
    var actual = GD_.take_right_while(array, func(n,a): return n > 2)
    
    expect(actual).to.equal([3,4])
