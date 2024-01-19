extends SimpleTest

func it_should_return_true_for_numbers():
	expect(GD_.is_number(0)).to.equal(true)
	expect(GD_.is_number(20.5)).to.equal(true)
	expect(GD_.is_number(NAN)).to.equal(true)
	expect(GD_.is_number(INF)).to.equal(true)

func should_return_false_for_non_numbers():
	var expected = GD_.map(Utils.falsey, func(v,_v): return v is int)
	var actual = GD_.map(Utils.falsey, GD_.is_number)
				
	expect(expected).to.equal(actual)
	expect(GD_.is_number([1, 2, 3])).falsey()
	expect(GD_.is_number(true)).falsey()
	expect(GD_.is_number({})).falsey()
	expect(GD_.is_number("")).falsey()
	expect(GD_.is_number(GD_.identity)).falsey()
	expect(GD_.is_number(RegEx.new())).falsey()
