extends SimpleTest


func it_returns_true_when_partial_match():
	var obj = { 'a': 1, 'b': 2, 'c': 3 }
	var fn = GD_.matches({"a":1,"c":3})
	
	expect(fn.call(obj)).to.be.truthy()

func it_returns_false_when_not_matching():
	var obj = { 'a': 1, 'b': 2, 'c': 3 }
	var fn = GD_.matches({"a":1,"d":3})
	
	expect(fn.call(obj)).to.be.falsey()
