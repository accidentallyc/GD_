extends SimpleTest


func it_must_not_show_this_test(_skip_suite):
	expect_fail("This test should be skipped because of the solo/skip")
