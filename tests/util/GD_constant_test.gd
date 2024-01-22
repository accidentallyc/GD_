extends SimpleTest

func it_should_return_same_value():
	var objects = GD_.map(range(2), GD_.constant({ 'a': 1 }))
	
	expect(objects[0]).to.strictly.equal(objects[1])


func it_should_Default_to_null():
	var objects = GD_.map(range(2), GD_.constant())
	expect(objects).to.equal([null,null])
