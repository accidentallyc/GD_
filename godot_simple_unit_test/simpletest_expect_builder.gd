class_name SimpleTest_ExpectBuilder


var test
var value = null
func _init(t, v:):
	test = t
	value = v

"""
/////////////////////////////
// FLUENT BUILDER KEYWORDS //
/////////////////////////////
"""
var a := self
var an := self
var to := self
var have := self
var been := self
var be := self
var IS := self
var are := self
var will := self
var NOT:
	get:
		__s.is_upright = false
		return self
var strictly = self:
	get:
		__s.is_strict = true
		return self

		
func __size_base(n, description: String = &"", equal_text = &"", comparator = null ):
	var collection_size = GD_.size(value)
	return test.__assert(
		__s.identity.call(comparator.call(collection_size, n)),
		description,
		&"Expected to {not}{equal} {v2} but got {v1}".format({
			&"v1":str(collection_size),
			&"v2":str(n),
			&"equal": equal_text,
			&"not": &"" if __s.is_upright else &"NOT ",
		})
	)
	
func size(n, description: String = &""):
	return __size_base(n, description, &"have size", GD_.eq)
	
func size_gt(n, description: String = &""):
	return __size_base(n, description, &"have size greater than", GD_.gt)	
	
func size_gte(n, description: String = &""):
	return __size_base(n, description, &"have size greater than or equal to", GD_.gte)
	
func size_lt(n, description: String = &""):
	return __size_base(n, description, &"have size lesser than", GD_.lt)	
	
func size_lte(n, description: String = &""):
	return __size_base(n, description,  &"have size lesser than or equal to", GD_.lte)
	
## Compares 'a' and 'b' using the  == operator
## When strict, it uses the is_same operator
## Example 1: expect(1).to.equal(1)
## Example 2: expect(1).to.strictly.equal(1)
func equal(other, description: String = &""):
	var is_strict = __s.is_strict
	return test.__assert(
		__s.equals.call(value,other),
		description,
		&"Expected {v1}({t1}) to {not}{equal} {v2}({t2})".format({
			&"v1":str(value),
			&"v2":str(other),
			&"t1":type_string(typeof(value)),
			&"t2":type_string(typeof(other)),
			&"equal": &"STRICTLY equal" if is_strict else &"loosely equal",
			&"not": &"" if __s.is_upright else &"NOT ",
		})
	)

## Checks if 'a' is truthy using a ternary operator
## Example 1: expect(true).to.be.truthy()
## Example 2: expect([1,2,3]).to.be.truthy()
func truthy(description: String = &""):
	return test.__assert(
		__s.identity.call(LambdaOperations.truthy(value)),
		description,
		&"Expected '{v1}' {to} be truthy".format({
			&"v1": str(value),
			&"to": &"to" if __s.is_upright else &"to NOT",
		})
	)
	
## Checks if 'a' is falsey using a ternary operator
## This has the same effect as NOT
## Example 1: expect(true).to.be.falsey()
## Example 2: expect([1,2,3]).to.be.falsey()
func falsey(description: String = &""):
	return test.__assert(
		__s.identity.call(not(LambdaOperations.truthy(value))),
		description,
		&"Expected '{v1}' {to} be falsey".format({
			&"v1": str(value),
			&"to": &"to" if __s.is_upright else &"to NOT",
		})
	)
	
func called(description: String = &""):
	if not(value is SimpleTest_Stub):
		return test.__append_error(
			&"'called' expected a stub but got '%s' instead. Use the stub() to make one" % str(value)
		)
		
	var vStub = value as SimpleTest_Stub
	return test.__assert(
		__s.identity.call(vStub.callstack.size() > 0),
		description,
		&"Expected callback {to} have been called atleast once".format({
			&"to": &"to" if __s.is_upright else &"NOT to"
		})
	)
	
func called_n_times(n:int, description: String = &""):
	if not(value is SimpleTest_Stub):
		return test.__append_error(
			&"'called' expected a stub but got '%s' instead. Use the stub() to make one" % value
		)
		
	var vStub = value as SimpleTest_Stub
	var count = vStub.callstack.size()
	return test.__assert(
		__s.identity.call(count == n),
		description,
		&"Expected stub {to} have been called {v1} times but got called {v2}".format({
			&"to": &"to" if __s.is_upright else &"NOT to",
			&"v1": n,
			&"v2": count
		})
	)
	

func value_in(thing, description: String = &""):
	var result:bool
	if thing is Dictionary:
		var r = []
		result = thing.values().find(thing)
	else:
		result = value in thing
		
	return test.__assert(
		__s.identity.call(result),
		description,
		&"Expected {v1} {to} {v2}".format({
			&"v1": value,
			&"to": &"to be in" if __s.is_upright else &"NOT to be in",
			&"v2": thing
		})
	)
	
	
func key_in(thing, description: String = &""):
	var result:bool
	if thing is Dictionary:
		var r = []
		result = thing.has(value)
	elif thing is Array and value is int:
		result = value < thing.size() and value >= 0
	else:
		result = value in thing
		
	return test.__assert(
		__s.identity.call(result),
		description,
		&"Expected {v1} {to} {v2}".format({
			&"v1": value,
			&"to": &"to be key of" if __s.is_upright else &"NOT to be key of",
			&"v2": thing
		})
	)
	
"""
/////////////////////////////
// INTERNAL STUFF //
/////////////////////////////
"""
var __s = {
	"is_upright": true,
	"is_strict": false,
	"equals": func (a,b):
		var r
		if __s.is_strict:
			r = LambdaOperations.equals_strict(a,b)
		else:
			r = LambdaOperations.equals(a,b)
		return __s.identity.call(r),
	"identity": func (r):
		return r if __s.is_upright else not(r),
}
