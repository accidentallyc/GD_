## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_defaults_to_zero_index():
    expect(GD_.nth(["a","b","c"])).to.equal("a")


func it_returns_nth_item():
    expect(GD_.nth(["a","b","c"],1)).to.equal("b")
    
    
func it_returns_negative_from_end():
    expect(GD_.nth(["a","b","c"],-2)).to.equal("b")
    
    
func it_returns_null_when_bad_index():
    expect(GD_.nth(["a","b","c"],-100)).to.equal(null)
    expect(GD_.nth(["a","b","c"],100)).to.equal(null)
