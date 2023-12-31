extends SimpleTest

var barney = { 'user': 'barney',  'active': true }
var fred = { 'user': 'fred', 'active': false }
var pebbles = { 'user': 'pebbles', 'active': false }
var users = [barney, fred, pebbles]

func it_should_drop_based_on_function():
	var expected = [fred, pebbles]
	expect(GD_.drop_while(users, func(o, _o): return o.active)).to.equal(expected)

func it_should_drop_with_matches_shorthand():
	var expected = [fred, pebbles]
	expect(GD_.drop_while(users, barney)).to.equal(expected)

func it_should_drop_with_matches_property_shorthand():
	var expected = [fred, pebbles]
	expect(GD_.drop_while(users, ['active', true])).to.equal(expected)

func it_should_drop_with_property_shorthand():
	var expected = [fred, pebbles]
	expect(GD_.drop_while(users, 'active')).to.equal(expected)
