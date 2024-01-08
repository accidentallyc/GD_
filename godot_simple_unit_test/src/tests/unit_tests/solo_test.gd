extends SimpleTest

func test_measure_skip1():
	test_name('[measure] this should be skipped implicity because of _solo')
	
	
func test_measure_skip2():
	test_name('[measure] this should be skipped implicity because of _solo')
	
	
func test_measure_solo(_solo):
	test_name('[measure] this should not be skipped cause it has _solo')

func test_for_actual_skip(_solo):
	
	var ln_item1 = _test_case_line_item_map['test_measure_skip1']
	expect(ln_item1.status).equal(&"SKIPPED")
	expect(ln_item1.childContainerNode.get_children()).to.be.falsey()
#
	var ln_item2 = _test_case_line_item_map['test_measure_skip2']
	expect(ln_item2.status).equal(&"SKIPPED")
	expect(ln_item2.childContainerNode.get_children()).to.be.falsey()
#
	var ln_pass = _test_case_line_item_map['test_measure_solo']
	expect(ln_pass.status).equal(&"PASS (SOLO)")
	expect(ln_item2.childContainerNode.get_children()).to.be.falsey()
