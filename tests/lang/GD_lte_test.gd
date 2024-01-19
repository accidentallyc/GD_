## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_functions_like_a_lesser_than_or_equals():
	expect(GD_.lte(3,5)).to.be.truthy()
	expect(GD_.lte(-INF,INF)).to.be.truthy()
	expect(GD_.lte(5,4)).to.be.falsey()
	expect(GD_.lte(5,4)).to.be.falsey()
	expect(GD_.lte(4,4)).to.be.truthy()
