extends SimpleTest


var array = [-12, 0, 12.12, 57, 88]

func it_can_return_the_index_of_item():
	expect(GD_.sorted_index_of(array, -12)).to.equal(0)
	expect(GD_.sorted_index_of(array, 0)).to.equal(1)
	expect(GD_.sorted_index_of(array, 12.12)).to.equal(2)
	expect(GD_.sorted_index_of(array, 57)).to.equal(3)
	expect(GD_.sorted_index_of(array, 88)).to.equal(4)
	expect(GD_.sorted_index_of(array, 100)).to.equal(-1)
	expect(GD_.sorted_index_of(array, -100)).to.equal(-1)
