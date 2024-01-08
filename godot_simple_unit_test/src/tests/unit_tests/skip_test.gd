extends SimpleTest

@export var skip_test_measure:SimpleTest

func it_should_skip_test_measure():
	var ln_item1 = skip_test_measure._test_case_line_item_map['test_suite_should_be_marked_as_skipped'];
	expect(ln_item1.status).equal(&"SKIPPED")
	expect(ln_item1.childContainerNode.get_children()).to.be.falsey()
	
	var ln_item2 = skip_test_measure._test_case_line_item_map['it_skips_this_too'];
	expect(ln_item2.status).equal(&"SKIPPED")
	expect(ln_item2.childContainerNode.get_children()).to.be.falsey()

