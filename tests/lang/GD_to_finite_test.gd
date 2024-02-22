extends SimpleTest

func it_returns_max_int_when_given_infinity():
    expect(GD_.to_finite(INF)).to.NOT.equal(INF)
    expect(GD_.to_finite(INF)).to.equal(9223372036854775807)
    expect(GD_.to_finite(-INF)).to.NOT.equal(-INF)
    expect(GD_.to_finite(-INF)).to.equal(-9223372036854775807)

func it_is_able_to_accept_strings_as_numbers():
    expect(GD_.to_finite("10.2")).to.equal(10.2)
    expect(GD_.to_finite("ABC")).to.equal(0)
