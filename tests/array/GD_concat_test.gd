extends SimpleTest

var thing = [1,2,3]
func it_creates_new_array_of_values():
	expect(GD_.concat(thing)).to.NOT.strictly.equal([1,2,3])


func it_can_append_non_array():
	expect(GD_.concat(thing,4)).to.equal([1,2,3,4])


func it_can_append_first_level_array():
	expect(GD_.concat(thing,[4,5],[[6]])).to.equal([1,2,3,4,5,[6]])
	
	
func it_can_append_up_to_n():
	expect(
		GD_.concat(
			thing,
			[4,5],
			[[6]],
			7,
			8,
			[9],
			)
	).to.equal([1,2,3,4,5,[6],7,8,9])
