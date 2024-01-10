extends SimpleTest

func it_returns_an_object_composed_form_key_value_pairs():
	expect(GD_.from_pairs([['a', 1], ['b', 2]])).to.equal({'a':1,'b':2})
