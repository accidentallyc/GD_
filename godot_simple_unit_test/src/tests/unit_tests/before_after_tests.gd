extends SimpleTest

var call_stack = []

func _before():
	call_stack.append("[%s] before" % call_stack.size())
	
func _before_each():
	call_stack.append("[%s] before each" % call_stack.size())

func _after():
	# This is a bit hard to detect since it runs after a test suite is done
	# Instead we create a node that should be detected by another test
	var n = Node.new()
	n.name = "After Each - Proof of Call"
	self.add_sibling(n, false)
	
func _after_each():
	call_stack.append("[%s] after each" % call_stack.size())
	
func test_run_1():
	call_stack.append("[%s] test run 1" % call_stack.size())
	
	var expected_call_stack = [
		"[0] before",
		"[1] before each",
		"[2] test run 1",
	]
	expect(expected_call_stack).to.equal(call_stack)
	expect($"../After Each - Proof of Call").to.be.falsey()
	
func test_run_2():
	call_stack.append("[%s] test run 2" % call_stack.size())
	
	var expected_call_stack = [
		"[0] before",
		"[1] before each",
		"[2] test run 1",
		"[3] after each",
		"[4] before each",
		"[5] test run 2",
	]
	expect(expected_call_stack).to.equal(call_stack)
	expect($"../After Each - Proof of Call").to.be.falsey()
