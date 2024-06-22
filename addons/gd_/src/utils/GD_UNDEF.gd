## This is a special class whose soul purpose is to replicate
## Undefined in GD_ internal classes and functions
## This is useful for situations where null is a separate value
## From not being set.
##
## E.g. 
##  func some_func(arg = GD_UNDEF):
##      if(arg == GD_UNDEF) return # Might occur on first run
##      assert(arg != null, "Error, received a bad value")
class_name GD_UNDEF

static func is_undefined(v, _v = null):
    return typeof(v) == typeof(GD_UNDEF) and GD_UNDEF == v

## Inverse of is_undefined. Can be used as a predicate
static func is_defined(v, _v = null):
    return typeof(v) != typeof(GD_UNDEF) or GD_UNDEF != v
pass
