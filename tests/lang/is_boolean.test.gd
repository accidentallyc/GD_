extends SimpleTest

func it_returns_true_for_booleans():
    expect(GD_.is_boolean(true)).to.be.truthy()
    expect(GD_.is_boolean(false)).to.be.truthy()

func it_returns_false_for_none_bools():
    var non_bools = [
        1,
        0,
        "",
        [],
        null
    ]
    
    for nb in non_bools:
        expect(GD_.is_boolean(nb)).to.be.falsey()

func it_can_be_used_as_an_iterator():
    var array = [ true, 1, false, null ]
    var result = GD_.map(array, GD_.is_boolean)
    expect(result).to.equal([true,false,true,false])
