extends SimpleTest

var barney = { 'user': 'barney',  'active': true }
var fred = { 'user': 'fred', 'active': false }
var pebbles = { 'user': 'pebbles', 'active': false }
var users = [barney,fred,pebbles]

func it_should_drop_right_while_based_on_function():
	var expected = [barney]
	expect(GD_.drop_right_while(users, func(o,_o): return not o.active)).to.equal(expected)


func it_should_drop_right_while_with_matches_shorthand():
	var expected = [barney, fred]
	expect(GD_.drop_right_while(users, pebbles)).to.equal(expected)


func it_should_drop_right_while_with_matches_property_shorthand():
	var expected = [barney]
	expect(GD_.drop_right_while(users, ['active', false])).to.equal(expected)


func it_should_drop_right_while_with_property_shorthand():
	var expected = [barney, fred, pebbles]
	expect(GD_.drop_right_while(users, 'active')).to.equal(expected)
