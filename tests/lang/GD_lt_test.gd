extends SimpleTest

func it_functions_like_a_lesser_than():
	expect(GD_.lt(3,5)).to.be.truthy()
	expect(GD_.lt(-INF,INF)).to.be.truthy()
	expect(GD_.lt(5,4)).to.be.falsey()
	expect(GD_.lt(5,4)).to.be.falsey()
	expect(GD_.lt(4,4)).to.be.falsey()
