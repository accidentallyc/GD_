extends SimpleTest

var array:Array = ['a', 'b', 'c']
var object = { 'a': 
		[
			{ 
				'b': { 'c': 3 } 
			}, 
			4
		] 
	}

func it_should_return_the_elements_corresponding_to_the_specified_keys():
	var actual = GD_.at(array, [0, 2])
	expect(actual).to.equal(['a','c'])
	
func it_should_return_undefined_for_nonexistent_keys():
	var actual = GD_.at(array, [2,4,0])
	expect(actual).to.equal(['c',null,'a'])

func it_should_accept_multiple_key_arguments():
	var actual = GD_.at(['a', 'b', 'c', 'd'], 3, 0, 2)
	expect(actual).equal(['d', 'a','c'])
	
func it_should_work_with_a_falsey_object_when_keys_are_given():
	var falsies = GD_.to_array(Utils.falsey)
	var expected = GD_.map(falsies, GD_.constant(null))
	var result = GD_.at(object,falsies)
	
	expect(result).to.equal(expected)
	

func it_should_work_with_an_object_for_object():
	var actual = GD_.at(object, ['a[0]:b:c', 'a[1]'])
	expect(actual).equal([3,4])
