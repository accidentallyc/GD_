extends SimpleTest


func it_passes_numbers_or_parses_as_number():
    expect(GD_.to_number(2)).to.equal(2)
    expect(GD_.to_number(2.2)).to.equal(2.2)
    expect(GD_.to_number(-5)).to.equal(-5)
    expect(GD_.to_number('500')).to.equal(500)
    expect(GD_.to_number('-3.9')).to.equal(-3.9)
    expect(GD_.to_number(&'-4.2')).to.equal(-4.2)
    expect(GD_.to_number(INF)).to.equal(INF)
    
func it_returns_NaN_for_invalid_types():
    var invalids = [
        'BAD',
        {},
        Vector2.DOWN
    ]
    
    for tmp in invalids:
        var result = GD_.to_number(tmp)
        expect(is_nan(result)).truthy()
