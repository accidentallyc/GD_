extends SimpleTest

## Canary test. The assertion in this test build on top of eachother
func test_foundation_test():
	test_name("FOUNDATION TEST - make sure this passes")
	expect(100).to.equal(999)
	assert(
		_errors.size() > 0 && _errors[0] == "Expected 100(int) to loosely equal 999(int)",
		"Canary test failed. All other tests should be considered fail."
	)
	
	# Reset to have it look "passed"
	_errors.clear() 
	
	
func test_equals_fails_when_not_equal():
	test_name("100 == 200 should FAIL")
	try(func (): expect(100).to.equal(200))
	assert_fail_message("Expected 100(int) to loosely equal 200(int)")
	
	
func test_NOT_inverts_the_fails_when_not_equal_test():
	test_name("'NOT' 100 == 200 should pass")
	try(func (): expect(100).to.NOT.equal(200))
	assert_passing()
	
	
func test_equals_passes_when_equal():
	test_name("100 == 100 should pass")
	try(func (): expect(100).to.equal(100))
	assert_passing()
	
	
func test_NOT_inverts_the_fails_when_equal_test():
	test_name("'NOT' 100 == 100 should FAIL")
	try(func (): expect(100).to.equal(100))
	assert_passing()
	
	
func test_equals_passes_when_equal_but_diff_type():
	test_name("equality between mismatching types but same value should pass")
	try(func (): expect(333).to.equal(333.0))
	assert_passing()
	
	try(func (): expect("333").to.equal(333.0))
	assert_passing()
	
	try(func (): expect([1,2,3]).to.equal([1,2,3]))
	assert_passing()
	
	
func test_strict_equals_checks_for_type():
	test_name("equality between mismatching types should FAIL")
	try(func (): expect(100).to.strictly.equal(100.0))
	assert_fail_message("Expected 100(int) to STRICTLY equal 100(float)")
	
	
func test_NOT_inverts_the_result():
	test_name("'NOT' equality between mismatching types should pass")
	try(func (): expect(100).to.NOT.equal(100))
	assert_fail_message("Expected 100(int) to NOT loosely equal 100(int)")
	
	
func test_truthy():
	# Test passing scenarios
	try(func (): 
		expect(true).to.be.truthy()
		expect(1).to.be.truthy()
		expect([1,2,3]).to.be.truthy()
		expect("foobar").to.be.truthy()
		expect(self).to.be.truthy()
	)
	assert_passing()
	
	# Test failing scenarios
	try( func (): 
		expect(false).to.be.truthy()
		expect(0).to.be.truthy()
		expect([]).to.be.truthy()
		expect("").to.be.truthy()
		expect(null).to.be.truthy()
	)
	assert_fail_message("Expected 'false' to be truthy")
	assert_fail_message("Expected '0' to be truthy")
	assert_fail_message("Expected '[]' to be truthy")
	assert_fail_message("Expected '' to be truthy")
	assert_fail_message("Expected '<null>' to be truthy")
	
	# Test passing scenarios
	try(func (): 
		expect(true).to.NOT.be.truthy()
		expect(1).to.NOT.be.truthy()
		expect([1,2,3]).to.NOT.be.truthy()
		expect("foobar").to.NOT.be.truthy()
	)
	assert_fail_message("Expected 'true' to NOT be truthy")
	assert_fail_message("Expected '1' to NOT be truthy")
	assert_fail_message("Expected '[1, 2, 3]' to NOT be truthy")
	assert_fail_message("Expected 'foobar' to NOT be truthy")
	
	
func test_stub_called_once():
	var handle = stub()
	try(func (): expect(handle).to.have.been.called())
	assert_fail_message("Expected callback to have been called atleast once")
	
	handle.callable() # This should now pass
	try(func (): expect(handle).to.have.been.called())
	assert_passing()


func test_stub_called_n_times():
	var handle = stub()
	try(func (): expect(handle).to.have.been.called_n_times(3))
	assert_fail_message("Expected stub to have been called 3 times but got called 0")
	
	handle.callable() 
	handle.callable() 
	handle.callable() # This should now pass
	try(func (): expect(handle).to.have.been.called_n_times(3))
	assert_passing()
	
	
func test_value_in():
	try( func (): 
		expect(5).to.be.a.value_in([1,4,5])
		expect("bar").to.be.a.value_in({"foo":"bar"})
		expect("foo").to.be.a.value_in("foobar")
	)
	assert_passing()
	
	# Negative Tests
	try( func (): 
		expect(5).to.NOT.be.a.value_in([1,4,5])
		expect("bar").to.NOT.be.a.value_in({"foo":"bar"})
		expect("baz").to.be.a.value_in("foobar")
	)
	assert_fail_message("Expected 5 NOT to be in [1, 4, 5]")
	assert_fail_message('Expected bar NOT to be in { "foo": "bar" }')
	assert_fail_message('Expected baz to be in foobar')
	
	
func test_key_in():
	try( func (): 
		expect(2).to.be.a.key_in([1,4,5])  #check if index 2 is here
		expect("foo").to.be.a.key_in({"foo":"bar"})
	)
	assert_passing()
	
	# Negative Tests
	try( func (): 
		expect(-1).to.be.a.key_in([1,4,5]) #check if index -1 is here
		expect(12).to.be.a.key_in([1,4,5]) #check if index 12 is here
		expect("foo").to.be.a.key_in([1,4,5]) #check if "foo" is part of array
		expect("bar").to.be.a.key_in({"foo":"bar"})
	)

	assert_fail_message("Expected -1 to be key of [1, 4, 5]")
	assert_fail_message("Expected 12 to be key of [1, 4, 5]")
	assert_fail_message("Expected foo to be key of [1, 4, 5]")
	assert_fail_message('Expected bar to be key of { "foo": "bar" }')
"""
////////////////////
// TEST UTILITIES //
////////////////////
"""	
	
static var __tabs = "     ";
## How do you assert on an assertion libraries assertion?
## BY USING itself ofcourse
func try(callable:Callable):
	callable.call()
	
func assert_fail_message(expected_error):
	if _errors.size() == 0:
		var message = &"Expected the error to be \n{tabs}'{err1}'\n but passed instead".format({
			&"tabs":__tabs,
			&"err1":expected_error
		})
		print(&"At `%s`:\n%s" % [_curr_test_name,message])
		expect_fail(message)
	else:
		for r in _errors:
			if r == expected_error:
				_errors.erase(r)
				return
	
		var error = _errors[0]
		var description = &"Expected the error to be \n{tabs}'{err1}' \nbut got \n{tabs}'{err2}'\ninstead ".format({
			&"tabs":__tabs,
			&"err1":expected_error,
			&"err2":error
		})
		expect_fail(description)
		var message = (&"At `{test}`:\n" + description).format({ 
			&"test":_curr_test_name
		})
		print(message)
	
func assert_passing():
	if _errors.size() == 0:
		return
	var errors = ""
	for r in _errors:
		errors += str(&"\n",__tabs,r)
	var description = &"Expected no error but instead got %s" % [errors]
	expect_fail(description)
	print(description)
