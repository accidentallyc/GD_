extends SimpleTest

func it_returns_the_arg_it_receives():
	var object = { 'a': 1 };
	expect(GD_.identity(object)).to.strictly.equal(object)
