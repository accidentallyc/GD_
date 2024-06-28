extends "./GD_math.gd"

## The opposite of GD_.before; 
##
## Creates a <a href="#what-are-commands">command</a> that takes a callable and wraps it in a callable
## that only invokes said callable after it's called n or more times.
## 
## Arguments
##      n (number): The number of calls before func is invoked.
##      func (Function): The function to restrict.
## Returns
##      (Function): Returns a command you can execute via exec(...args) or execv([...args]).
## Example
##      var fn = func (): print("hello world")
##      var restricted = GD_.after(2, fn)
##      
##      for i in 5: restricted.exec() # Or restricted.exec.call()
##      # => Only prints "hello world" 3 times (starting on the 3rd call)
## Notes
##     >> JS Variations
##      Theres a weird edge case where if you supply 1 as the number
##      Then it doesnt execute atleast once. That behavior has not
##      been replicated.
##     >> Memory Gotcha
##      To implement this, GD_ keeps an internal record of how many times
##      The passed in function has been called. That tracker cannot be
##      garbage collected so use this function sparingly.
static func after(max_count, callable:Callable) -> GDInternal_AfterCommand:
    return GDInternal_AfterCommand.new(callable, max_count)
    
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func ary(a=0, b=0, c=0): not_implemented() 


## Creates a <a href="#what-are-commands">command</a> that takes a callable and wraps it in a callable
## that invokes func while it's called less than n times. 
## Subsequent calls to the created function return the result of 
## the last func invocation.
##
## Arguments
##      n (number): The number of calls at which func is no longer invoked.
##      func (Callable): The function to restrict.
## Returns
##      (Function): Returns a command you can execute via exec(...args) or execv([...args]).
## Example
##      var fn = func (): print("hello world")
##      var restricted = GD_.before(2, fn)
##      
##      for i in 5: restricted.exec() # Or restricted.exec.call()
##      # => Only prints "hello world" twice
## Notes
##     >> JS Variations
##      Theres a weird edge case where if you supply 1 as the number
##      Then it doesnt execute atleast once. That behavior has not
##      been replicated.
static func before(up_to_count, callable:Callable) -> GDInternal_BeforeCommand: 
    return GDInternal_BeforeCommand.new(callable, up_to_count)
    
static func bind(a=0, b=0, c=0): not_implemented()
static func bind_key(a=0, b=0, c=0): not_implemented()

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func curry(a=0, b=0, c=0): not_implemented() 

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func curry_right(a=0, b=0, c=0): not_implemented() 

## Creates a <a href="#what-are-commands">command</a> that takes a callable and wraps it in a callable
## that delays invoking func until after wait 
## milliseconds have elapsed since the last time the debounced callable 
## was invoked. The debounced callable comes with a cancel method to cancel 
## delayed func invocations and a flush method to immediately invoke them. 
## 
## Provide options to indicate whether func should be invoked on the leading 
## and/or trailing edge of the wait timeout. The func is invoked with the last 
## arguments provided to the debounced callable. Subsequent calls to the debounced 
## callable return the result of the last func invocation.
## 
## Note: If leading and trailing options are true, func is invoked on the 
## trailing edge of the timeout only if the debounced callable is invoked more 
## than once during the wait timeout.
## 
## If wait is 0 and leading is false, func invocation is deferred until to the 
## next tick, similar to setTimeout with a timeout of 0.
## 
## See David Corbacho's article for details over the differences between _.debounce and _.throttle.
## Arguments
##      func (Function): The callable to debounce.
##      [wait=0] (number): The number of milliseconds to delay.
##      [options={}] (Object): The options object.
##      [options.leading=false] (boolean): Specify invoking on the leading edge of the timeout.
##      [options.maxWait=INF] (number): The maximum time func is allowed to be delayed before it's invoked.
##      [options.trailing=true] (boolean): Specify invoking on the trailing edge of the timeout.
## Returns
##      (Function): Returns a command you can execute via exec(...args) or execv([...args]).
## Example
##      var my_func = func(): print("hello")
##      var debounced = GD_.debounce(my_func, wait_time) 
static func debounce(callable:Callable, time:float, dict:Dictionary = GDInternal_DebounceCommand.default_opts) -> GDInternal_DebounceCommand:
    assert_resource_group()
    return GDInternal_DebounceCommand.new(callable, time, dict)
static func defer(a=0, b=0, c=0): not_implemented()
static func delay(a=0, b=0, c=0): not_implemented()
static func flip(a=0, b=0, c=0): not_implemented()
static func memoize(a=0, b=0, c=0): not_implemented()
static func negate(a=0, b=0, c=0): not_implemented()
static func once(a=0, b=0, c=0): not_implemented()
static func over_args(a=0, b=0, c=0): not_implemented()
static func partial(a=0, b=0, c=0): not_implemented()
static func partial_right(a=0, b=0, c=0): not_implemented()
static func rearg(a=0, b=0, c=0): not_implemented()
static func rest(a=0, b=0, c=0): not_implemented()
static func spread(a=0, b=0, c=0): not_implemented()
static func throttle(a=0, b=0, c=0): not_implemented()
static func unary(a=0, b=0, c=0): not_implemented()
static func wrap_func(a=0, b=0, c=0): not_implemented()
