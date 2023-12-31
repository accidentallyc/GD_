extends SimpleTest

func it_has_equality_tests():
	expect(true).to.equal(true)
	expect(true).to.NOT.equal(false)

	expect([1,2,3]).to.equal([1,2,3])
	expect([1,2,3]).to.NOT.strictly.equal([1,2,3])
	
func it_can_customize_display_name():
	test_name("This test has been renamed")

func it_can_create_stubs():
	var cb = stub()
	
	cb.callable()
	
	expect(cb).to.have.been.called()
