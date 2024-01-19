## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_returns_a_string():
	expect(GD_.join([1,2,3],"~")).equal("1~2~3")


func it_has_default_separator():
	expect(GD_.join([1,2,3])).equal("1,2,3")
