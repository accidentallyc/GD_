extends SimpleTest

@export var skipped_test:SimpleTest

func it_should_show_this():
	expect('it_must_not_show_this_test').NOT.a.key_in(skipped_test._test_case_line_item_map)
