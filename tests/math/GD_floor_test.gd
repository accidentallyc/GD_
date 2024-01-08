extends SimpleTest

func it_performs_floor():
	expect(GD_.floor(4.006)).to.equal(4)


func it_accepts_positive_precision():
	expect(GD_.floor(0.046, 2)).to.equal(0.04)
 

func it_accepts_negative_precision():
	expect(GD_.floor(4060, -2)).to.equal(4000)
