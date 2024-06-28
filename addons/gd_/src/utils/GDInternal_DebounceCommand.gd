extends RefCounted

## Do not directly call, use GD_.debounce
class_name GDInternal_DebounceCommand

var fn:Callable
## Time to wait until the next execution is allowed
var wait_time:float = 0
var timer:Timer
var opts:Dictionary

const default_opts = {}
const default_args = []

var last_args

var is_leading:bool:
    get:
        return opts.get("leading", false)
    set(v):
        opts["leading"] = v
        
var is_trailing:bool:
    get:
        return opts.get("trailing", true)
    set(v):
        opts["trailing"] = v

func _init(fn, wait_time = 0, opts:Dictionary = {}):
    self.fn = fn
    self.wait_time = wait_time
    self.opts = opts
    
    timer = Timer.new()   
    timer.wait_time = wait_time
    timer.one_shot = true
    timer.timeout.connect(call_debounced_func)
    GDInternal_ResourceGroup.entangle(self, [timer])
    GDInternal_ResourceGroup.add_child(timer)
    
func exec(arg1 = GD_UNDEF,arg2 = GD_UNDEF,arg3 = GD_UNDEF,arg4 = GD_UNDEF,arg5 = GD_UNDEF,arg6 = GD_UNDEF,arg7 = GD_UNDEF,arg8 = GD_UNDEF,arg9 = GD_UNDEF,arg10 = GD_UNDEF):
    var args = GD_.filter([arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10], GD_UNDEF.is_defined)
    return execv(args)

func execv(arguments:Array = default_args):
    if opts.get("trailing",true):
        last_args = arguments
    
    if timer.is_stopped():
        last_args = arguments
        if is_leading:
            call_debounced_func()
        # else do nothing special
    elif is_trailing:
        pass
    timer.stop()
    timer.start(wait_time)
 
func call_debounced_func():
    if is_leading == false and is_trailing == false:
        # Special case when both are off
        return
    
    if last_args == null: 
        return
    fn.callv(last_args)
    last_args = null # Purge last_args so it doesnt get called again
      

func get_or_create_timer():
    pass
