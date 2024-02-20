extends SimpleTest


func it_returns_max_int_when_given_infinity():
    expect(GD_.to_finite(INF)).to.NOT.equal(INF)
    expect(GD_.to_finite(INF)).to.equal(9223372036854775807)
    expect(GD_.to_finite(-INF)).to.NOT.equal(-INF)
    expect(GD_.to_finite(-INF)).to.equal(-9223372036854775807)
