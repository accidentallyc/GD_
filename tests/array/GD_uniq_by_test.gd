## @TODO Reuse tests from lodash repo
extends SimpleTest


func it_returns_a_new_array_without_duplicates_and_defaults_to_identity():
	var array = [2, 1, 2]
	var result = GD_.uniq_by(array)
	
	expect(result).to.equal([2,1])
	expect(result).to.strictly.NOT.equal(array)


func it_can_use_a_custom_iteratee():
	var array = [2.1, 1.2, 2.3]
	var result = GD_.uniq_by(array, GD_.floor)
	
	expect(result).to.equal([2.1, 1.2])


func it_can_use_shorthands():
	var result = GD_.uniq_by([{ 'x': 1 }, { 'x': 2 }, { 'x': 1 }], 'x')
	
	expect(result).to.equal([{ 'x': 1 }, { 'x': 2 }])
