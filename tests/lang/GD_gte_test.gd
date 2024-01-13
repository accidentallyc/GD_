extends SimpleTest

func it_functions_like_a_Greater_than_or_equal():
	expect(GD_.gte(5,3)).to.be.truthy()
	expect(GD_.gte(INF,-INF)).to.be.truthy()
	expect(GD_.gte(4,4)).to.be.truthy()
	expect(GD_.gte(4,5)).to.be.falsey()
