extends SimpleTest

func it_should_call_the_func_after_timeout_if_leading_is_false():
    var wait_time = 0.25
    var config = {
        "leading":false
    }
    var call_stub = stub()
    var debounced = GD_.debounce(call_stub.callable, wait_time, config)

    # Ensure we are at a good state
    expect(call_stub).called_n_times(0, "No calls should be here yet")
    
    # Call once and check if LEADING forced the FN to be called 
    debounced.exec()
    expect(call_stub).called_n_times(0, "Leading should only be called after timeout")
    
    # Should not call again, since there was only 1 instance, even after a wait
    await wait_until(timer_done(debounced.timer))
    expect(call_stub).called_n_times(1) 

func it_should_call_the_func_if_leading_is_true():
    var wait_time = 0.25
    var config = {
        "leading":true
    }
    var call_stub = stub()
    var debounced = GD_.debounce(call_stub.callable, wait_time, config)

    # Ensure we are at a good state
    expect(call_stub).called_n_times(0, "No calls should be here yet")
    
    # Call once and check if LEADING forced the FN to be called 
    debounced.exec()
    expect(call_stub).called_n_times(1, "Leading should insta call internal func")
    
    # Should not call again, since there was only 1 instance, even after a wait
    await wait_until(timer_done(debounced.timer))
    expect(call_stub).called_n_times(1) 
    
    # However calling it twice should call the func an additional 2 times
    # One for leading, and one for the "next call".
    # You can replicate in lodash using the code below
    """
    var call = 0
    var test = _.debounce(() => console.log("Hi ",call++),3000,{leading:true, trailing:true})
    test() // should log 0 instantly
    test() // should log 1 after 3 seconds
    """
    debounced.exec()
    expect(call_stub).called_n_times(2) 
    debounced.exec()
    await wait_until(timer_done(debounced.timer))
    expect(call_stub).called_n_times(3) 
    
func it_should_not_do_another_call_even_after_wait_time_if_trailing_false():
    var wait_time = 0.25
    var config = {
        "leading":true,
        "trailing":false
    }
    var call_stub = stub()
    var debounced = GD_.debounce(call_stub.callable, wait_time, config)

    # Ensure we are at a good state
    expect(call_stub).called_n_times(0, "No calls should be here yet")

    # However calling it twice should call the func an additional 2 times
    # One for leading, and one for the "next call".
    # You can replicate in lodash using the code below
    """
    var call = 0
    var test = _.debounce(() => console.log("Hi ",call++),3000,{leading:true, trailing:false})
    test() // should log 0 instantly
    test() // should not log anything
    """
    debounced.exec()
    expect(call_stub).called_n_times(1) 
    debounced.exec()
    expect(call_stub).called_n_times(1) 
    await wait_until(timer_done(debounced.timer))
    expect(call_stub).called_n_times(1, "If trailing is off, it should not fire again") 
    
func it_should_not_do_anything_if_both_leading():
    var wait_time = 0.25
    var config = {
        "leading": false,
        "trailing": false
    }
    var call_stub = stub()
    var debounced = GD_.debounce(call_stub.callable, wait_time, config)
    
    debounced.exec()
    debounced.exec()
    debounced.exec()
    await wait_until(timer_done(debounced.timer))
    expect(call_stub).called_n_times(0)

# This is a predicate for wait_until
func timer_done(timer):
    return func (): 
        return timer.is_stopped()
