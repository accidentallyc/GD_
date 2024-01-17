extends SimpleTest


func it_returns_a_new_array_without_duplicates():
	var array = [2, 1, 2]
	var result = GD_.uniq(array)
	
	expect(result).to.equal([2,1])
	expect(result).to.strictly.NOT.equal(array)


func it_returns_the_first_occurence():
	var instance_1 = {"name":"Fred"}
	var instance_2 = {"name":"Fred"}
	var instance_3 = {"name":"Fred"}
	var array = [instance_1,instance_2,instance_3]
	var result = GD_.uniq(array)

	expect(result[0]).to.strictly.equal(instance_1)
