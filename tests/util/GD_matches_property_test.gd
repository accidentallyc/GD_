extends SimpleTest


func it_returns_true_when_partial_match():
	var obj = { 'a': 4, 'b': 5, 'c': 6 }

	var fn = GD_.matches_property('a', 4)
	expect(fn.call(obj)).to.be.truthy()

func it_returns_false_when_not_matching():
	var obj = { 'a': 4, 'b': 5, 'c': 6 }

	var fn = GD_.matches_property('z', 4)
	expect(fn.call(obj)).to.be.falsey()
