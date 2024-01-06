extends SimpleTest


func square(v,_i):
	return v * v
	
	
func it_defaults_to_identity_iteratee():
	var result = GD_.map([4, 8])
	expect(result).to.equal([4,8])


func it_is_able_to_call_iteratee_for_every_item():
	var result = GD_.map([4, 8],square)
	expect(result).to.equal([16,64])


func it_is_able_to_call_for_objects():
	var result = GD_.map({ 'a': 4, 'b': 8 },square)
	expect(result).to.equal([16,64])


func it_is_able_to_use_property_shorthand():
	var users = [
	  { 'user': 'barney' },
	  { 'user': 'fred' }
	]
	
	var result = GD_.map(users, 'user');
	expect(result).to.equal(['barney', 'fred'])
