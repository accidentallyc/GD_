extends RefCounted

## Do not directly call, use GD_.after
class_name GDInternal_AfterCommand

var fn:Callable
var count = 0
var max_count = 0

func _init(fn, max_count):
    self.fn = fn
    self.max_count = max_count
    
func exec(arg1 = GD_UNDEF,arg2 = GD_UNDEF,arg3 = GD_UNDEF,arg4 = GD_UNDEF,arg5 = GD_UNDEF,arg6 = GD_UNDEF,arg7 = GD_UNDEF,arg8 = GD_UNDEF,arg9 = GD_UNDEF,arg10 = GD_UNDEF):
    var args = GD_.filter([arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10], GD_UNDEF.is_defined)
    return execv(args)

func execv(arguments:Array):
    if count >= max_count:
        return fn.callv(arguments)
    count += 1
    return null
    
