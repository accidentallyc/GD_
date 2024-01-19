## @TODO Reuse tests from lodash repo
extends SimpleTest


func it_returns_the_elements_of_array_1_not_in_array_2():
	expect(GD_.difference([2,1],[2,3])).equal([1])


func it_results_are_the_same_order_of_array_1():
	expect(GD_.difference([1,2,3,4],[9,3,1,7])).equal([2,4])
