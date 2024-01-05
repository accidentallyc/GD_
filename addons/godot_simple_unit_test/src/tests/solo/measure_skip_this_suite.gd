extends SimpleTest


func it_must_not_show_this_test():
	expect_fail("This test should be skipped because of the solo/skip")
