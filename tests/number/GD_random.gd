extends SimpleTest

func should_return_zero_or_one_when_not_args():
    expect(GD_.random()).to.value_in([0, 1])

func should_support_min_and_max():
    var _min = 5
    var _max = 10
    var result = GD_.random(_min, _max)
    var state1 = result >= _min
    var state2 = result <= _max
    expect([state1, state2]).to.equal([true, true])

func should_support_not_providing_max():
    var _min = 0
    var _max = 5
    var result = GD_.random(_max)
    var state1 = result >= _min
    var state2 = result <= _max
    expect([state1, state2]).to.equal([true, true])


func should_swap_min_and_max_when_min_larger_than_max():
    var _min = 4
    var _max = 2
    var v = GD_.random(_min, _max)
    var expected = (v == 2 or v == 3 or v == 4)
    expect(expected).to.equal(true)


func it_should_support_larger_int():
    var _min = 2 ** 36
    var _max = 2 ** 62
    var result = GD_.random(_min, _max)
    var state1 = result >= _min
    var state2 = result <= _max
    expect([state1, state2]).to.equal([true, true])


func should_coerce_arguments_to_finite_numbers():
    expect(GD_.random(NAN)).to.value_in([0, 1, 9223372036854775807])

func should_support_floats():
    var _min = 1.5
    var _max = 1.6
    var result = GD_.random(_min, _max)
    expect(int(result) % 1).to.equal(0)
    var state1 = result >= _min
    var state2 = result <= _max
    expect([state1, state2]).to.equal([true, true])

func should_support_providing_floating():
    var _min = 1.5
    var _max = 1.6
    var result = GD_.random(_min, _max, true)
    var state1 = result >= _min
    var state2 = result <= _max
    expect([state1, state2]).to.equal([true, true])
