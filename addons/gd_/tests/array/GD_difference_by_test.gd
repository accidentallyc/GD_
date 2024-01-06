extends SimpleTest

func it_returns_left_array_copy_with_right_bits_removed_using_iterator():
	expect(GD_.difference_by([2.1, 1.2], [2.3, 3.4], GD_.floor)).equal([1.2])
	
	GD_.identity

func it_returns_left_array_get_all_instances_removed():
	expect(
		GD_.difference_by([2.1, 1.2, 5.2, 2.6, 2.7, 7.7], [2.3, 3.4], GD_.floor)
		).equal([1.2,5.2,7.7])


func it_is_able_to_use_property_shorthand():
	expect(
		GD_.difference_by([{ 'x': 2 }, { 'x': 1 }], [{ 'x': 1 }], 'x')
	).equal([{'x':2}])
