extends SimpleTest

func it_acts_same_as_equal():
	
	expect(GD_.eq(1,1)).to.be.truthy()
	expect(GD_.eq(1.0,1)).to.be.truthy()
	expect(GD_.eq(0,1)).to.be.falsey()
