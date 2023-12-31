extends SimpleTest

var users = [
	{ 'user': 'barney',  'active': false },
	{ 'user': 'fred',    'active': false },
	{ 'user': 'pebbles', 'active': true }
]

func it_should_find_index_based_on_function():
	var index = GD_.find_index(users, func(o): return o.user == 'barney')
	expect(index).to.equal(0)

func it_should_find_index_with_matches_shorthand():
	var index = GD_.find_index(users, { 'user': 'fred', 'active': false })
	expect(index).to.equal(1)

func it_should_find_index_with_matches_property_shorthand():
	var index = GD_.find_index(users, ['active', false])
	expect(index).to.equal(0)

func it_should_find_index_with_property_shorthand():
	var index = GD_.find_index(users, 'active')
	expect(index).to.equal(2)
