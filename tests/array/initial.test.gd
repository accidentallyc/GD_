## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_returns_all_but_last_element():
    expect(GD_.initial([1,2,3])).to.equal([1,2])
    
func it_returns_empty_array():
    expect(GD_.initial([1])).to.equal([])
    expect(GD_.initial([])).to.equal([])
