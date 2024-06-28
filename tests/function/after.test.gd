extends SimpleTest

func it_can_forward_args():
    var args = []
    var push_rand = func (n):
        args.append(n)
        
    GD_.after(0, push_rand).exec(500)
    expect(args).to.be.equal([500])

func it_can_call_func_only_after_count():
    var call_stub = stub()
        
    var new_func = GD_.after(2, call_stub.callable)
        
    new_func.exec()
    new_func.exec()
    
    expect(call_stub).called_n_times(0)
    for i in 3:
        new_func.exec()
    
    expect(call_stub).called_n_times(3)
    
func it_returns_last_valid_call_else_null():
    var last_rand = []
    var push_rand = func ():
        var n = randi()
        last_rand.append(n)
        return n
        
    var new_func = GD_.after(2, push_rand)
    
    expect(new_func.exec()).equal(null)
    expect(new_func.exec()).equal(null)
    for i in 5:
        var result = new_func.exec()
        expect(result).to.equal(GD_.last(last_rand))

func it_should_be_the_same_when_using_callable():
    var call_stub = stub()
        
    var new_func = GD_.after(2, call_stub.callable)
    var callable = new_func.exec
        
    new_func.exec()
    callable.call()
    
    expect(call_stub).called_n_times(0)
    new_func.exec()
    callable.call()
    
    expect(call_stub).called_n_times(2)
