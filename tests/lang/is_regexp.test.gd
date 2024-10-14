extends SimpleTest


func it_returns_true_for_regex():
	expect(GD_.is_regexp(RegEx.create_from_string("\\w+"))).to.be.truthy()
	expect(GD_.is_regexp("\\w+")).to.be.falsey()

func it_can_be_used_in_map():
	var input = [
		RegEx.create_from_string("\\w+"),
		"\\w+",
		300
	]
	
	var result = GD_.map(input, GD_.is_regexp)
	expect(result).equal([true,false,false])
