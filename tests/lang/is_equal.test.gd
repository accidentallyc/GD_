## @TODO Reuse tests from lodash repo
extends SimpleTest



func it_can_handle_different_types():
	var inputs = {
		#"dictionary": [
			#{'name':'Barney','job':{'name':"Stone Age Person", "test":"foo"}},
			#{'job':{'name':"Stone Age Person", "test":"foo"},'name':'Barney'},
		#],
		#"diff num types": [
			#1, 
			#1.0
		#],
		#"diff array types": [
			#PackedInt32Array([1,2,3]),
			#[1,2,3]
		#],
		"deep-dict with varying subtypes with same values": [
			{"numbers": PackedInt32Array([1,2,3]), "age":200},
			{"age":200,"numbers": [1,2,3]},
		]
	}
	for key in inputs:
		var a = inputs[key][0]
		var b = inputs[key][1]
		expect(GD_.is_equal(a,b)).to.be.truthy("Failed at " + key)

func it_can_handle_node():
	var a:Node = TestNode.new()
	a.health = 200
	
	var b:Node = TestNode.new()
	b.health = 200
	
	# Compare to self should work
	expect(GD_.is_equal(a,a)).to.be.truthy()
	
	# Compare to others should not
	expect(GD_.is_equal(a,b)).to.be.falsey()
	
		
class TestNode:
	extends Node
	@export var health = 0
	@export var external:TestNode
