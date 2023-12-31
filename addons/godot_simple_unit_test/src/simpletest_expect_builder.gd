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
var to := self
var have := self
var been := self
var be := self
var IS := self
var are := self
var will := self
var NOT:
	get:
		__flag_not_notted = false
		return self
var strictly = self:
	get:
		__equals = LambdaOperations.equals_strict
		return self

## Compares 'a' and 'b' using the  == operator
## When strict, it uses the is_same operator
## Example 1: expect(1).to.equal(1)
## Example 2: expect(1).to.strictly.equal(1)
func equal(other, description: String = &""):
	var is_strict = is_same(__equals,LambdaOperations.equals_strict) 
	return test.__assert(
		__to_notted(__equals.call(value,other)),
		description,
		&"Expected {v1}({t1}) to {not}{equal} {v2}({t2})".format({
			&"v1":str(value),
			&"v2":str(other),
			&"t1":SimpleTest_Utils.type_to_str(typeof(value)),
			&"t2":SimpleTest_Utils.type_to_str(typeof(other)),
			&"equal": &"STRICTLY equal" if is_strict else &"loosely equal",
			&"not": &"" if __flag_not_notted else &"NOT ",
		})
	)

## Checks if 'a' is truthy using a ternary operator
## Example 1: expect(true).to.be.truthy()
## Example 2: expect([1,2,3]).to.be.truthy()
func truthy(description: String = &""):
	return test.__assert(
		__to_notted(LambdaOperations.truthy(value)),
		description,
		&"Expected '{v1}' {to} be truthy".format({
			&"v1": str(value),
			&"to": &"to" if __flag_not_notted else &"to NOT",
		})
	)
	
## Checks if 'a' is falsey using a ternary operator
## This has the same effect as NOT
## Example 1: expect(true).to.be.falsey()
## Example 2: expect([1,2,3]).to.be.falsey()
func falsey(description: String = &""):
	return test.__assert(
		__to_notted(not(LambdaOperations.truthy(value))),
		description,
		&"Expected '{v1}' {to} be falsey".format({
			&"v1": str(value),
			&"to": &"to" if __flag_not_notted else &"to NOT",
		})
	)
	
func called(description: String = &""):
	if not(value is SimpleTest_Stub):
		return test.__append_error(
			&"'called' expected a stub but got '%s' instead. Use the stub() to make one" % str(value)
		)
		
	var vStub = value as SimpleTest_Stub
	return test.__assert(
		__to_notted(
			vStub.callstack.size() > 0
		),
		description,
		&"Expected callback {to} have been called atleast once".format({
			&"to": &"to" if __flag_not_notted else &"NOT to"
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
		__to_notted(count == n),
		description,
		&"Expected stub {to} have been called {v1} times but got called {v2}".format({
			&"to": &"to" if __flag_not_notted else &"NOT to",
			&"v1": n,
			&"v2": count
		})
	)
"""
/////////////////////////////
// INTERNAL STUFF //
/////////////////////////////
"""
var __flag_not_notted = true
func __to_notted(r:bool):
	return r if __flag_not_notted else not(r)
	
var  __equals:Callable = LambdaOperations.equals
	
