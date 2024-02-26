extends "./GD_math.gd"

"""
CATEGORY: Function
"""
## The opposite of GD_.before; this method creates a function that 
## invokes func once it's called n or more times.
## 
## Arguments
## 		n (number): The number of calls before func is invoked.
## 		func (Function): The function to restrict.
## Returns
## 		(Function): Returns the new restricted function.
## Example
##		var fn = func (): print("hello world")
## 		var restricted = GD_.after(2, fn)
## 		
##		for i in 5: fn.call()
##		# => Only prints "hello world" 3 times (starting on the 3rd call)
## Notes
##		>> JS Variations
##			Theres a weird edge case where if you supply 1 as the number
##			Then it doesnt execute atleast once. That behavior has not
##			been replicated.
##		>> Memory Gotcha
##			To implement this, GD_ keeps an internal record of how many times
##			The passed in function has been called. That tracker cannot be
##			garbage collected so use this function sparingly.
static func after(after_count, callable:Callable):
    return __INTERNAL__.base_after(after_count, callable)
    
# @TODO guarded method by map, every, filter, mapValues, reject, some
static func ary(a=0, b=0, c=0): not_implemented() 

## Creates a function that invokes func, with the this binding and 
## arguments of the created function, while it's called less than n times. 
## Subsequent calls to the created function return the result of 
## the last func invocation.
##
## Arguments
## 		n (number): The number of calls at which func is no longer invoked.
## 		func (Callable): The function to restrict.
## Returns
## 		(Function): Returns the new restricted function.
## Example
##		var fn = func (): print("hello world")
## 		var restricted = GD_.before(2, fn)
## 		
##		for i in 5: fn.call()
##		# => Only prints "hello world" twice
## Notes
##		>> JS Variations
##			Theres a weird edge case where if you supply 1 as the number
##			Then it doesnt execute atleast once. That behavior has not
##			been replicated.
##		>> Memory Gotcha
##			To implement this, GD_ keeps an internal record of how many times
##			The passed in function has been called. That tracker cannot be
##			garbage collected so use this function sparingly.
static func before(up_to_count, callable:Callable): 
    return __INTERNAL__.base_before(up_to_count, callable)
    
    
static func bind(a=0, b=0, c=0): not_implemented()
static func bind_key(a=0, b=0, c=0): not_implemented()

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func curry(a=0, b=0, c=0): not_implemented() 

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func curry_right(a=0, b=0, c=0): not_implemented() 

static func debounce(a=0, b=0, c=0): not_implemented()
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
