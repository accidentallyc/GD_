extends SimpleTest



func it_can_clone_basic_things():
	Utils.regex

	var cases = {
		"arrays": Utils.array,
		"dictionary": Utils.dict,
		"packed array": Utils.packed_array,
		"string": "foobar",
		"number": 1,
		"Vector": Vector2.ONE,
	}

	
	for key in cases:
		var val = cases[key]
		var result = GD_.clone(val)
		
		
		
		expect(result).to.equal(val, "Failed to return exact value for %s"%key)
		
		# If mutable then ensure its not just returned
		if not GD_.is_immutable(val):
			
			expect(result).to.strictly.NOT.equal(val, "Failed to return new copy of the item for %s"%key)
		

func it_can_clone_nodes():
	var tmp = Utils.node
	var result = GD_.clone(tmp)
	
	expect(result is Node).to.be.truthy()
	expect(result).to.NOT.strictly.equal(tmp)
	expect(result.name).to.equal(tmp.name)
	
func it_can_clone_regex():
	var tmp = Utils.regex as RegEx
	var result = GD_.clone(tmp) as RegEx
	
	expect(result is RegEx).to.be.truthy()
	expect(result).to.NOT.strictly.equal(tmp)
	expect(result.get_pattern()).equal(tmp.get_pattern())
