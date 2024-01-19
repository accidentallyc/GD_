## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_mutates_original_array_without_the_indexes():
	var array = ['a', 'b', 'c', 'd'];
	GD_.pull_at(array, [1, 3]);
	
	expect(array).to.equal(['a','c'])
	
func it_returns_removed_items_based_on_index():
	var array = ['a', 'b', 'c', 'd'];
	var pulled = GD_.pull_at(array, [1, 3]);

	expect(pulled).to.equal(['b','d'])

func it_doesnt_throw_errors_with_invalid_indexes():
	var array = ['a', 'b', 'c', 'd'];
	GD_.pull_at(array, [-1, 999,'c'])

	expect(array).to.equal(['a','b','c','d'])
