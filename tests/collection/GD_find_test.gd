## @TODO Reuse tests from lodash repo
extends SimpleTest

var barney = { 'user': 'barney',  'age': 36, 'active': true }
var fred = { 'user': 'fred',    'age': 40, 'active': false }
var pebbles = { 'user': 'pebbles', 'age': 1,  'active': true }
var users = [barney,fred,pebbles];

func it_can_find_first_truthy():
	var collection = [0,"",null,1]
	var result = GD_.find(collection)
	expect(result).to.equal(1)


func it_can_find_first_lambda():
	var result = GD_.find(users, func(u, _i): return u.age < 40)
	expect(result).to.equal(barney)


func it_can_find_using_matches_shorthand():
	var result = GD_.find(users, { 'age': 1, 'active': true })
	expect(result).to.equal(pebbles)


func it_can_find_using_matches_property_shorthand():
	var result = GD_.find(users, ['active', false])
	expect(result).to.equal(fred)


func it_can_find_using_property_shorthand():
	var result = GD_.find(users, 'active')
	expect(result).to.equal(barney)
