extends SimpleTest


func it_should_accept_an_iteratee():
    #var actual = GD_.xor_by([2.1, 1.2], [2.3, 3.4], GD_.floor)
    #expect(actual).to.equal([1.2, 3.4])

    var actual = GD_.xor_by([{ "x": 1 }], [{ "x": 2 }, { "x": 1 }], 'x')
    expect(actual).to.equal([{ "x": 2 }])
