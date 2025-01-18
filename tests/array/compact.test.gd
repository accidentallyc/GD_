## @TODO Reuse tests from lodash repo 
extends SimpleTest

func it_can_remove_all_falsy_values():
	expect(GD_.compact([0, 1, false, 2, '', 3,null,[],{},4])).equal([1,2,3,4])
