extends SimpleTest

func it_can_forward_args():
	var args = []
	var push_rand = func (n):
		args.append(n)
		
	GD_.before(2, push_rand).exec(300)
	expect(args).to.be.equal([300])
	
func it_can_call_func_up_to_count():
	var call_stub = stub()
		
	var new_func = GD_.before(2, call_stub.callable)
		
	for i in 5:
		new_func.exec()
	
	expect(call_stub).called_n_times(2)
	
func it_returns_last_valid_exec():
	var randarray = []
	var push_rand = func ():
		var n = 100
		randarray.append(n)
		return randarray
		
	var new_func = GD_.before(2, push_rand)
	
	expect(new_func.exec()).to.equal([100])
	expect(new_func.exec()).to.equal([100,100])
	# Subsequent calls should just return the last valid call's result
	expect(new_func.exec()).to.equal([100,100])
	expect(new_func.exec()).to.equal([100,100])
	expect(new_func.exec()).to.equal([100,100])
