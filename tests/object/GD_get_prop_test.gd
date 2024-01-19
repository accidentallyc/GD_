## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_can_access_instances_of_none_gd_object():
	var vector = Vector2(2,5)
	var result = GD_.get_prop(vector, "x")
	expect(result).to.equal(2)

func it_can_get_single_prop_from_dictionary():
	var dict = {"foo":"bar"}
	var result = GD_.get_prop(dict,"foo")
	expect(result).to.equal("bar")


func it_can_get_single_prop_from_object():
	var node = Node2D.new()
	node.global_position = Vector2(15,10)
	
	var result = GD_.get_prop(node,"global_position")
	expect(result).to.equal(Vector2(15,10))
	node.free()
	
	
func it_can_get_single_prop_from_an_array():
	var array = {"a":["never","gonna","give","you","up"]}
	
	var result = GD_.get_prop(array,"a:3")
	expect(result).to.equal("you")
	
	
func it_can_get_nested_properties():
	var node = Node2D.new()
	node.global_position = Vector2(999,123)
	
	var everything_everywhere_all_at_once = {
		"array": ["hello", node, "world"]
	}

	var path = "array:1:global_position:y"
	var result = GD_.get_prop(everything_everywhere_all_at_once,path)
	expect(result).equal(123)
	
func it_can_access_by_array():
	var node = Node2D.new()
	node.global_position = Vector2(999,123)
	
	var everything_everywhere_all_at_once = {
		"array": ["hello", node, "world"]
	}

	var path = ["array",1,"global_position","y"]
	var result = GD_.get_prop(everything_everywhere_all_at_once,path)
	expect(result).equal(123)


func it_returns_null_in_invalid_cases():
	var vector = Vector2(2,5)
	
	expect(GD_.get_prop(vector, vector)).to.equal(null)
	expect(GD_.get_prop(vector, null)).to.equal(null)
	expect(GD_.get_prop(vector, {})).to.equal(null)
	expect(GD_.get_prop(vector, "baz")).to.equal(null)


func it_returns_default_if_provided():
	var vector = Vector2(2,5)
	
	expect(GD_.get_prop(vector, vector, "foobar")).to.equal("foobar")
	expect(GD_.get_prop(vector, null, "foobar")).to.equal("foobar")
	expect(GD_.get_prop(vector, {}, "foobar")).to.equal("foobar")
	expect(GD_.get_prop(vector, "baz", "foobar")).to.equal("foobar")
