## @TODO Reuse tests from lodash repo
extends SimpleTest

var array = [4, 5, 5, 5, 6]
func it_returns_the_index_of_last_occurence():
	expect(GD_.sorted_last_index(array, 5)).to.equal(4)


func it_is_able_to_return_last_index_if_beyond_last():
	expect(GD_.sorted_last_index(array, 7)).to.equal(5)


func it_is_able_to_return_last_index_if_below_first():
	expect(GD_.sorted_last_index(array, 1)).to.equal(0)
