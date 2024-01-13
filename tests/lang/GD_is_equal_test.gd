extends SimpleTest

func it_is_deep_equal():
	var a = {'name':'Barney','job':{'name':"Stone Age Person", "test":"foo"}}
	var b = {'job':{'name':"Stone Age Person", "test":"foo"},'name':'Barney'}
	a.kid = "Bam Bam"
	b.kid = "Bam Bam"
	expect(GD_.is_equal(a,b)).be.truthy()
