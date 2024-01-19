## @TODO Reuse tests from lodash repo
extends SimpleTest

var barney = { 'user': 'barney',  'age': 36, 'active': true, 'gender':'m' }
var fred = { 'user': 'fred',    'age': 40, 'active': false, 'gender':'m' }
var pebbles = { 'user': 'pebbles', 'age': 1,  'active': true , 'gender':'f' }
var users = [barney,fred,pebbles];

func it_counts_using_truthiness():
	var collection = ["foo",0,"",null,1,null,1,"foo",null]
	var result = GD_.count_by(collection)
	expect(result).to.equal({
				"":1,
				"0":1,
				"1":2,
				"foo": 2,
				"<null>":3,
			})


func it_counts_using_lambda():
	var result = GD_.count_by(users, func(u,_u): return u.user)
	expect(result).to.equal({
		"barney": 1,
		"fred": 1,
		"pebbles":1
	})


func it_counts_by_using_matches_shorthand():
	var result = GD_.count_by(users, { 'gender': 'm', 'active': true })
	expect(result).to.equal({
		"true": 1,
		"false": 2
	})


func it_counts_by_using_matches_property_shorthand():
	var result = GD_.count_by(users, ['active', false])
	expect(result).to.equal({
		"true": 1,
		"false": 2
	})


func it_counts_by_using_property_shorthand():
	var result = GD_.count_by(users, 'active')
	expect(result).to.equal({
		"true": 2,
		"false": 1
	})
