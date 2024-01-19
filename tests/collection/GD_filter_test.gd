## @TODO Reuse tests from lodash repo
extends SimpleTest

var barney =  { 'user': 'barney', 'age': 36, 'active': true }
var fred = { 'user': 'fred',   'age': 40, 'active': false }
var users = [barney,fred]


func it_can_filter_by_truthy():
	var collection = [0,"","foo",null,1]
	var result = GD_.filter(collection)
	expect(result).to.equal(["foo",1])


func it_can_filter_by_lambda():
	var result = GD_.filter(users, func(o,_i): return !o.active)
	expect(result).to.equal([fred])


func it_can_filter_using_matches_shorthand():
	var result = GD_.filter(users, { 'age': 36, 'active': true })
	expect(result).to.equal([barney])


func it_can_filter_using_matches_property_shorthand():
	var result = GD_.filter(users, ['active', false])
	expect(result).to.equal([fred])


func it_can_filter_using_property_shorthand():
	var result = GD_.filter(users, 'active')
	expect(result).to.equal([barney])
