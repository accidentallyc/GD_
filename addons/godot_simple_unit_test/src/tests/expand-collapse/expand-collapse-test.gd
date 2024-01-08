extends SimpleTest

@export var measure:SimpleTest


func it_shows_collapse_button():
	var ln_item = measure._ln_item
	var passing_ln_item = measure._test_case_line_item_map["it_is_a_passing_test_measure"]
	var failing_ln_item = measure._test_case_line_item_map["it_is_a_failing_test_measure"]
	
	expect(ln_item.collapse_toggle.visible).to.be.truthy("If it has children it should show")
	expect(passing_ln_item.collapse_toggle.visible).to.be.falsey("Passing should have no children")
	expect(failing_ln_item.collapse_toggle.visible).to.be.truthy("Failing lines are considered children")


func it_collapses_when_clicked():
	var ln_item = measure._ln_item
	var passing_ln_item = measure._test_case_line_item_map["it_is_a_passing_test_measure"]
	var failing_ln_item = measure._test_case_line_item_map["it_is_a_failing_test_measure"]
	
	ln_item.collapse_toggle.button_up.emit()
	
	expect(ln_item.childContainerNode.visible).to.be.falsey("Children should be invisible")
