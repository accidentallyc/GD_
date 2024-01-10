extends SimpleTest

func test_after_should_have_been_called():
	var node = $"../After Each - Proof of Call"
	expect(node).to.be.truthy()
	if node:
		node.queue_free()
