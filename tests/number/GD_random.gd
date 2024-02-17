extends SimpleTest

func should_return_zero_or_one_when_not_args():
    var v = GD_.random()
    expect(v == 0 or v == 1)

func should_support_min_and_max():
    var _min = 5
    var _max = 10
    var result = GD_.random(_min, _max)
    expect(result >= _min and result <= _max)

func should_support_not_providing_max():
    var _min = 5
    var _max = 10
    var result = GD_.random(_max)
    expect(result >= _min and result <= _max)

func should_swap_min_and_max_when_min_larger_than_max():
    var _min = 4
    var _max = 2
    var expected = [2, 3, 4]

    var actual = GD_.random(_min, _max)
    expect(actual == expected[0] or actual == expected[1] or actual == expected[2])

func it_should_support_larger_int():
    var _min = 2 ** 36
    var _max = 2 ** 62
    var result = GD_.random(_min, _max)
    expect(result >= _min and result <= _max)

func should_coerce_arguments_to_finite_numbers():
    var result = GD_.random(NAN)
    expect(result == 0 or result == 1 or result == 2147483647)

func should_support_floats():
    var _min = 1.5
    var _max = 1.6
    var result = GD_.random(_min, _max)
    expect(int(result) % 1)
    expect(result >= _min and result <= _max)

func should_support_providing_floating():
    var _min = 1.5
    var _max = 1.6
    var result = GD_.random(_min, _max, true)
    expect(result >= _min and result <= _max)