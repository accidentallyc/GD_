extends SimpleTest


func it_can_call_func_only_after_count():
	var call_stub = stub()
		
	var new_func = GD_.after(2, call_stub.callable)
		
	new_func.call()
	new_func.call()
	
	expect(call_stub).called_n_times(0)
	for i in 3:
		new_func.call()
	
	expect(call_stub).called_n_times(3)
	
func it_returns_last_valid_call_else_null():
	var last_rand = []
	var push_rand = func ():
		var n = randi()
		last_rand.append(n)
		return n
		
	var new_func = GD_.after(2, push_rand)
	
	expect(new_func.call()).equal(null)
	expect(new_func.call()).equal(null)
	for i in 5:
		var result = new_func.call()
		expect(result).to.equal(GD_.last(last_rand))

func it_should_return_a_noop_if_given_a_bad_count():
	var bad_nums = Utils.falsey
	bad_nums["NAN"] = NAN
	
	for key in bad_nums:
		var n = bad_nums[key]
		expect( GD_.after(n, GD_.identity)).to.equal(GD_.identity,"Failed at %s"%key)
