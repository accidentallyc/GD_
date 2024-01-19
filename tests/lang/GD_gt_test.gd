## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_functions_like_a_Greater_than():
	expect(GD_.gt(5,3)).to.be.truthy()
	expect(GD_.gt(INF,-INF)).to.be.truthy()
	expect(GD_.gt(4,4)).to.be.falsey()
	expect(GD_.gt(4,5)).to.be.falsey()
