extends SimpleTest

const array = [1, 2, 3];
    
func it_should_take_last_2_elements():
    var result = GD_.take_right(array, 2)
    expect(result).to.equal([2, 3])

func it_should_treat_falsey_values_as_0_except_null():
    for key in Utils.falsey:
        var f = Utils.falsey[key]
        var result = GD_.take_right(array, f)
        expect(result).to.equal( [3] if f == null else [], "Failed at %s" % key)

func it_should_return_an_empty_array_when_n_lt_1():
    var inputs = [0,-1,-INF]
    
    for i in inputs:
        expect(GD_.take_right(array,i)).equal([], "Failed at %s" % i)
        
func it_should_return_all_elements_when_n_gte_size():
    var inputs = [99, len(array) + 1, INF]
    
    for i in inputs:
        expect(GD_.take_right(array,i)).equal([1,2,3], "Failed at %s" % i)
    
func it_should_work_as_an_iteratee_for_methods_like_map():
    var array = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
    ]
    
    var actual = GD_.map(array, GD_.take_right)
    expect(actual).to.equal([[3], [6], [9]])
