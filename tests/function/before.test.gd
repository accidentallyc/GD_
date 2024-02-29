extends SimpleTest

func it_can_call_func_up_to_count():
    var call_stub = stub()
        
    var new_func = GD_.before(2, call_stub.callable)
        
    for i in 5:
        new_func.call()
    
    expect(call_stub).called_n_times(2)
    
func it_returns_last_valid_call():
    var randarray = []
    var push_rand = func ():
        var n = randi()
        randarray.append(n)
        return n
        
    var new_func = GD_.before(2, push_rand)
    
    new_func.call()
    new_func.call() # This call shouldve been cached as randarray[1]
    for i in 5:
        expect(new_func.call()).to.equal(randarray[1])

func it_should_return_a_noop_if_given_a_bad_count():
    var bad_nums = Utils.falsey
    bad_nums["NAN"] = NAN
    
    for key in bad_nums:
        var n = bad_nums[key]
        expect( GD_.before(n, GD_.identity)).to.equal(GD_.noop,"Failed at %s"%key)
