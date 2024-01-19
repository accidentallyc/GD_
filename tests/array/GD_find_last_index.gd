## @TODO Reuse tests from lodash repo
extends SimpleTest

var users = [
	{ 'user': 'barney',  'active': true },
	{ 'user': 'fred',    'active': false },
	{ 'user': 'pebbles', 'active': false }
]

func it_should_find_last_index_based_on_function():
	var index = GD_.find_last_index(users, func(o,_o): return o.user == 'pebbles')
	expect(index).to.equal(2)


func it_should_find_last_index_with_matches_shorthand():
	var index = GD_.find_last_index(users, { 'user': 'barney', 'active': true })
	expect(index).to.equal(0)


func it_should_find_last_index_with_matches_property_shorthand():
	var index = GD_.find_last_index(users, ['active', false])
	expect(index).to.equal(2)


func it_should_find_last_index_with_property_shorthand():
	var index = GD_.find_last_index(users, 'active')
	expect(index).to.equal(0)
