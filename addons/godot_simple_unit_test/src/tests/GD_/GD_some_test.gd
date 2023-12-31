extends SimpleTest


var barney = { 'user': 'barney',  'age': 36, 'active': true, 'gender':'m' }
var fred = { 'user': 'fred',    'age': 40, 'active': false, 'gender':'m' }
var pebbles = { 'user': 'pebbles', 'age': 1,  'active': true , 'gender':'f' }
var users = [barney,fred,pebbles];

func it_returns_true_for_any_truthy():
	var collection = [null,0,"",[],{},"foo"]
	var result = GD__.some(collection)
	expect(result).to.be.truthy()
	
	
func it_returns_false_if_all_falsey():
	var collection = [null,0,"",[],{}]
	var result = GD__.some(collection)
	expect(result).to.be.falsey()


func it_somes_using_lambda():
	var result = GD__.some(users, func(u,_u): return u.age > 5)
	expect(result).to.be.truthy()


func it_somes_by_using_matches_shorthand():
	var result = GD__.some(users, { 'gender': 'm', 'active': true })
	expect(result).to.be.truthy()


func it_somes_by_using_matches_property_shorthand():
	var result = GD__.some(users, ['active', false])
	expect(result).to.be.truthy()


func it_somes_by_using_property_shorthand():
	var result = GD__.some(users, 'active')
	expect(result).to.be.truthy()
