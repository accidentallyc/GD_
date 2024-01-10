extends SimpleTest

func it_is_a_passing_test_measure():
	pass
	
func it_is_a_failing_test_measure():
	expect_fail("Random failure reason")
