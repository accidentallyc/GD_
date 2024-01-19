## @TODO Reuse tests from lodash repo
extends SimpleTest


func it_can_return_index_of_last_occurence():
	expect(GD_.sorted_last_index_of([4, 5, 5, 5, 6], 5)).to.equal(3)


func it_can_return_ngetaive_one_if_not_found():
	expect(GD_.sorted_last_index_of([4, 5, 5, 5, 6], 2)).to.equal(-1)
