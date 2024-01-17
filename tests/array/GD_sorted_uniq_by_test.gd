extends SimpleTest


func it_can_return_a_duplicate_free_array_using_default_identity():
	var result = GD_.sorted_uniq_by([1, 1, 2]);
	
	expect(result).to.equal([1, 2])
	
	
func it_can_return_a_duplicate_free_array_using_custom_iteratee():
	var result = GD_.sorted_uniq_by([1, 1, 2], GD_.floor);
	
	expect(result).to.equal([1, 2])


func it_can_use_shorthands_as_an_iteratee():
	var result = GD_.sorted_uniq_by([{'id':1}, {'id':1}, {'id':2}], 'id');
	
	expect(result).to.equal([{'id':1}, {'id':2}])
