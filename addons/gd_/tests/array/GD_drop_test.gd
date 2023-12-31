extends SimpleTest

func it_should_drop_item_1_by_default():
	expect(GD_.drop([1,2,3])).to.equal([2,3])


func it_should_drop_only_n_from_start():
	expect(GD_.drop([1, 2, 3], 2)).to.equal([3])
 

func it_should_drop_everything_if_beyond_size():
	expect(GD_.drop([1, 2, 3], 5)).to.equal([])

 
func it_should_drop_nothing():
	expect(GD_.drop([1, 2, 3], 0)).to.equal([1,2,3])
