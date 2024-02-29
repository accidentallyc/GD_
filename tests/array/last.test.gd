## @TODO Reuse tests from lodash repo
extends SimpleTest


func it_returns_found_member_starting_from_end():
    GD_.last_index_of
    expect(GD_.last([1,2,3])).to.equal(3)
    
    
func it_returns_found_member_():
    expect(GD_.last([])).to.equal(null)
