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
	
## Similar to godot's bind it creates a new callable that invokes the provided
## callable with some arguments pre-filled however unlike godot's native bind
## it binds from left to right, and accepts placeholders using GD_.
##
## Arguments
## 		func (Function): The function to bind.
## 		thisArg (*): The this binding of func.
## 		[partials] (...*): The arguments to be partially applied.
## Returns
## 		(Function): Returns the new bound function.
## Example
## 		func greet(hi, person, etc): return "%s %s! %s?" % [hi,person,etc]
## 		var bound = GD_.bind(greet,"Greetings")
## 		bound.call("Fred","How are you") # "Greetings Fred! How are you?"
## 		
##		# Bound with placeholders.
## 		var bound = GD_.bind(greet,"Hello", GD_, "Watcha doing")
## 		bound.call("friend") # "Hello friend! Watcha doing?"
## Notes
##		>> JS Variations
##			Godot is not a prototyping language, we cannot easily replace 
##			the "this"/"self" component of the callable
##		>> Version 4.2
##			Bind uses GD_.callf internally. In 4.2 callf falls back to just
##			calling "callable.callv()" which means that if the total arguments do
## 			not exactly match this function will not be called. In 4.3, this is
##			not a problem.
static func bind(orig_cb,a1=GD_UNDEF, b1=GD_UNDEF,c1=GD_UNDEF,d1=GD_UNDEF,e1=GD_UNDEF,f1=GD_UNDEF,g1=GD_UNDEF,h1=GD_UNDEF,i1=GD_UNDEF,j1=GD_UNDEF): 
	assert(orig_cb is Callable, "Expected a callable")
			
	return func(a2=GD_UNDEF, b2=GD_UNDEF,c2=GD_UNDEF,d2=GD_UNDEF,e2=GD_UNDEF,f2=GD_UNDEF,g2=GD_UNDEF,h2=GD_UNDEF,i2=GD_UNDEF,j2=GD_UNDEF):
		var bounds_args = [a1,b1,c1,d1,e1,f1,g1,h1,i1,j1] 
		var unbound_args = [j2,i2,h2,g2,f2,e2,d2,c2,b2,a2] # Inverted for faster popping
		var total := bounds_args.size() + unbound_args.size()
		var args = []
		var cursor = 0
		
		for arg in bounds_args:
			if GD_UNDEF.is_undefined(arg): continue
			# Check if its GD_ without explicity referencing it 
			# to avoid cyclical dependencies
			if arg is Script and "__INTERNAL__" in arg:
				args.append(unbound_args.pop_back())
			else:
				args.append(arg)
		for i in range(unbound_args.size() - 1, -1, -1):
			var arg = unbound_args[i]
			if GD_UNDEF.is_undefined(arg): continue
			args.append(arg)
			
		return __INTERNAL__.callf(orig_cb, args)
	
static func bind_key(a=0, b=0, c=0): not_implemented()
	
## For gdscript v4.3 upwards it calls a callable, via callv 
## and ensures that the arguments always fits the argument count.
## On unsupported versions, this falls back to a regular callv.
##
## This behavior is similar to how javascript executes calls.
## 
## Lodash Equivalent 
##     None
## Arguments
##      [cb] (Callable): The callable to execute
##      [args] (Array): The arguments to supply to the callable
## Returns
##		(Variant): Returns whatever [cb] returns
## Example
## 		var cb:Callable = func(a,b,c): return [a,b,c]
## 		GD_.callf(cb, [1])			# returns [1,null,null]
## 		GD_.callf(cb, [1,2])		# returns [1,2,null]
## 		GD_.callf(cb, [1,2,3])		# returns [1,2,3]
## 		GD_.callf(cb, [1,2,3,4,5])	# returns [1,2,3]
static func callf(cb:Callable, args:Array):
	return __INTERNAL__.callf(cb,args)

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
##      [wait=0] (number): The number of seconds to delay.
##      [options={}] (Object): The options object.
##      [options.leading=false] (boolean): Specify invoking on the leading edge of the timeout.
##      [options.maxWait=INF] (number): The maximum time func is allowed to be delayed before it's invoked.
##      [options.trailing=true] (boolean): Specify invoking on the trailing edge of the timeout.
## Returns
##      (Function): Returns a command you can execute via exec(...args) or execv([...args]).
## Example
##      var my_func = func(): print("hello")
##      var debounced = GD_.debounce(my_func, wait_time) 
##		debounced.exec()
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
