## @TODO Reuse tests from lodash repo
extends SimpleTest


func it_removes_nothing_if_no_elements():
	var array = ['a', 'b'];
	 
	GD_.pull(array)
	expect(array).to.equal(['a','b'])


func it_removes_elem_by_mutating_array():
	var array = ['a', 'b'];
	var returned = GD_.pull(array, 'a'); 
	
	expect(array).to.equal(['b'])
	expect(array).strictly.equal(returned)


func it_removes_all_occurences():
	var array = ['a', 'b', 'c', 'a', 'b', 'c'];
 
	GD_.pull(array, 'a','c'); 
	expect(array).to.equal(['b','b'])
