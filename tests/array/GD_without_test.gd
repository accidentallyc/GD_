extends SimpleTest

func it_should_return_the_difference_of_values():
	var actual = GD_.without([2, 1, 2, 3], 1, 2)
	expect(actual).equal([3])
	

func it_should_not_mutate_array():
	var array = [2, 1, 2, 3]
	var actual = GD_.without(array, 1, 2)
	expect(actual).NOT.strictly.equal(array)


func it_should_use_strict_equality_to_determine_the_values_to_reject():
	var object1 = { "a": 1 }
	var object2 = { "b": 2 }
	var array = [object1, object2]

	expect(GD_.without(array, { "a": 1 })).equal(array,"Failed at NOT removing strict equality")
	expect(GD_.without(array, object1)).equal([object2],"Failed to remove using strict equality")


func it_should_remove_all_occurrences_of_each_value_from_an_array():
	var array = [1, 2, 3, 1, 2, 3]
	expect(GD_.without(array, 1, 2)).equal([3, 3])
