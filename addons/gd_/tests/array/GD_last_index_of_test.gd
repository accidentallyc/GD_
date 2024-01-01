extends SimpleTest


func it_returns_last_index():
	expect(GD_.last_index_of([1,1,1],1)).to.equal(2)

func it_accepts_negative_index():
	expect(GD_.last_index_of([1,0,1,0,1],1,-1)).to.equal(4)
