extends SimpleTest

func test_ln_item_is_assigned():
	assert(_ln_item is Control,	"Line item must a text control")

func test_ln_item_can_display_pass_or_fail():
	_ln_item.status = &"FAIL"
	assert(_ln_item.statusNode.text == &"Fail",  "Looks like status node wasnt updated")
	
	_ln_item.status = &"PASS"
	assert(_ln_item.statusNode.text == &"Pass",  "Looks like status node wasnt updated")

func test_ln_item_can_display_description():
	var original_name = _ln_item.description
	_ln_item.description = &"foobar"
	assert(_ln_item.descpNode.text == "  -  foobar",  "Looks like description node wasnt updated")
	_ln_item.description = original_name

func test_ln_item_reflects_failure():
	assert(_results.size() == 0, "There should be no errors at the start of a test")
	expect_fail()
	assert(_results.size() == 1, "There should be exactly 1 error now")
	
	# Clear results to make it "pass"
	_results.clear()
