extends SimpleTest

func it_should_unzip_with_default():
    var zipped = [['a', 1, true], ['b', 2, false]]
    var expected =  [['a', 'b'], [1, 2], [true, false]]
    var result = GD_.unzip(zipped)
    expect(result).to.equal(expected)
