extends SimpleTest

func it_is_deep_equal():
	var a = [{'name':'Barney','job':{'name':"Stone Age Person"}}]
	var b = [{'name':'Barney','job':{'name':"Stone Age Person"}}]
	expect(GD_.is_equal(a,b)).be.truthy()
