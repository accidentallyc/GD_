## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_returns_left_array_copy_with_right_bits_removed_using_iterator():
	expect(GD_.difference_by([2.1, 1.2], [2.3, 3.4], GD_.floor)).equal([1.2])
	
func it_returns_left_array_get_all_instances_removed():
	expect(
		GD_.difference_by([2.1, 1.2, 5.2, 2.6, 2.7, 7.7], [2.3, 3.4], GD_.floor)
		).equal([1.2,5.2,7.7])

func it_is_able_to_use_property_shorthand():
	expect(
		GD_.difference_by([{ 'x': 2 }, { 'x': 1 }], [{ 'x': 1 }], 'x')
	).equal([{'x':2}])

func it_can_accept_a_callable_with_N_args():
	var ary_1 := [2.1, 1.2, 5.2, 2.6, 2.7, 7.7]
	var ary_2 := [2.3, 3.4]
	var expected := [1.2,5.2,7.7]
	var cb_1:Callable = func(a): return GD_.floor(a)
	var cb_2:Callable = func(a,b): return GD_.floor(a)
	var cb_3:Callable = func(a,b,c): return GD_.floor(a)

	expect(GD_.difference_by(ary_1, ary_2, cb_2)).equal(expected, "Should work with 2 args")
	if GD_.is_version(">=4.3"):
		expect(GD_.difference_by(ary_1, ary_2, cb_1)).equal(expected, "Should work with 1 args")
		expect(GD_.difference_by(ary_1, ary_2, cb_3)).equal(expected, "Should work with 3 args")
