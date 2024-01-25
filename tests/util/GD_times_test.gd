extends SimpleTest

func it_uses_value_from_callback():
	expect(GD_.times(2, func (a,b): return 123)).to.equal([123,123])


func it_defaults_to_iteratee_when_null():
	expect(GD_.times(2, null)).to.equal([0,1], 'Failed at null literal')
	expect(GD_.times(2)).to.equal([0,1], 'Failed at omitted iteratee')


func it_returns_empty_array_for_invalid_nums():
	expect(GD_.times(-1)).equal([])
	expect(GD_.times(0)).equal([])
	expect(GD_.times(-INF)).equal([])
