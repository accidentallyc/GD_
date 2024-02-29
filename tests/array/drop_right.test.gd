## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_should_drop_right_item_1_by_default():
    expect(GD_.drop_right([1,2,3])).to.equal([1,2])


func it_should_drop_right_only_n_from_start():
    expect(GD_.drop_right([1, 2, 3], 2)).to.equal([1])
 

func it_should_drop_right_everything_if_beyond_size():
    expect(GD_.drop_right([1, 2, 3], 5)).to.equal([])

 
func it_should_drop_right_nothing():
    expect(GD_.drop_right([1, 2, 3], 0)).to.equal([1,2,3])
