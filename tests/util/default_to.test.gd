extends SimpleTest

func it_returns_first_if_not_null():
    expect(GD_.default_to(1,10)).to.equal(1)


func it_returns_first_even_falsey():
    expect(GD_.default_to(0,10)).to.equal(0)
    expect(GD_.default_to(false,10)).to.equal(false)
    expect(GD_.default_to([],10)).to.equal([])


func it_returns_second_if_null():
    expect(GD_.default_to(null,10)).to.equal(10)


func it_returns_second_if_NaN():
    expect(GD_.default_to(NAN,10)).to.equal(10)
