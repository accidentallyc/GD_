## @TODO Reuse tests from lodash repo
extends SimpleTest


func it_removes_the_element_by_mutating_array():
	var array = [1, 2, 3, 4];
	var evens = GD_.remove(array, func(n, _i): 
		return n % 2 == 0
	)
	
	expect(array).to.equal([1,3])
	expect(evens).to.equal([2,4])
	

func it_defaults_to_identity_which_removes_all_truthy():
	var array = [1, 2, 0, [], "", null, 3, 4];
	var removed = GD_.remove(array)
	
	expect(removed).to.equal([1,2,3,4])
	expect(array).to.equal([0, [], "", null])
