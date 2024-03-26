extends SimpleTest

func it_should_unzip_with_default():
    var zipped = [['a', 1, true], ['b', 2, false]]
    var expected =  [['a', 'b'], [1, 2], [true, false]]
    var result = GD_.unzip_with(zipped)
    expect(result).to.equal(expected)

func it_should_unzip_arrays_combining_regrouped_elements_with_iteratee():
    var array = [
        [1, 4],
        [2, 5],
        [3, 6],
    ];

    var actual = GD_.unzip_with(array, func (a, b, c): return a + b + c);

    expect(actual).to.equal([6, 15]);
