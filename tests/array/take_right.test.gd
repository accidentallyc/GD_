extends SimpleTest

const array = [1, 2, 3];
    
func it_should_take_last_2_elements(_solo_suite):
    var result = GD_.take_right(array, 2)
    expect(result).to.equal([2, 3])

func it_should_treat_falsey_values_as_0():
    for fval in Utils.falsey:
        print(fval)
    var result = GD_.take_right(array, 2)
    expect(result).to.equal([2, 3])
