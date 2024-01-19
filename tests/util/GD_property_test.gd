## @TODO Reuse tests from lodash repo
extends SimpleTest


func it_can_access_instances_of_none_gd_object():
	var vector = Vector2(2,5)
	var fn = GD_.property("x")
	expect(fn.call(vector)).to.equal(2)

func it_can_get_single_prop_from_dictionary():
	var dict = {"foo":"bar"}
	var fn = GD_.property("foo")
	expect(fn.call(dict)).to.equal("bar")


func it_can_get_single_prop_from_object():
	var node = Node2D.new()
	node.global_position = Vector2(15,10)
	
	var fn = GD_.property("global_position")
	expect(fn.call(node)).to.equal(Vector2(15,10))
	node.free()
	
	
func it_can_get_single_prop_from_an_array():
	var array = ["never","gonna","give","you","up"]
	
	var fn = GD_.property("3")
	expect(fn.call(array)).to.equal("you")
	
	
func it_can_get_nested_properties():
	var node = Node2D.new()
	node.global_position = Vector2(999,123)
	
	var everything_everywhere_all_at_once = {
		"array": ["hello", node, "world"]
	}

	var fn = GD_.property("array:1:global_position:y")
	expect(fn.call(everything_everywhere_all_at_once)).equal(123)
