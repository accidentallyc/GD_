# Base class  for storing functions that have the same name as globalscope types
# And other random utility functions


# Use this to differentiate betwen default null
# and actual null values. Do not use outside of this class.
class UNDEFINED: 
    static var ref:UNDEFINED
    
    func _init():
        ref = self

static var _UNDEF_ = Internal._UNDEF_:
    get: return Internal._UNDEF_
static var _EMPTY_ARRAY_ = []

static var __INTERNAL__:Internal = Internal.new():
    get:
        # We gotta do this because static vars are null in EditorScripts 
        if __INTERNAL__ == null:
            __INTERNAL__ = Internal.new()
        return __INTERNAL__

"""
Reference to original functions
"""

## Original floor to use in GD_.floor
static func __floor(n): return floor(n)

static func disable_warnings():
    __INTERNAL__.is_warning_enabled = false

static func enable_warnings():
    __INTERNAL__.is_warning_enabled = true

static func gd_warn(str:String):
    __INTERNAL__.gd_warn(str)
"""
Internal utility function
"""

## Wrapping it in a class o we can hide the implementation from being visible
## when accessing GD_.
class Internal:
    static var _UNDEF_ = UNDEFINED.new()
    # Used for testing purposes
    var last_warning
    var is_warning_enabled = true
    var string_to_path_rx:RegEx
    var id_ctr = 0
    
    # Keeps track of how many times
    # a specific function has been called
    # - Used in before and after trackers 
    var callable_trackers = {}
    
    func _init():
        string_to_path_rx = RegEx.new()
        string_to_path_rx.compile(
         str(
            "(\\[(?<key>[\\w\\s\'\"\\.]+)?\\])",
            "|",
            "(?<key>\'?[\\w\\s\\.]+\'?)",
            "|",
            "(?<key>\"?[\\w\\s\\.]+\"?)",
            )
        )
    
    func gd_warn(str:String):
        last_warning = str
        if is_warning_enabled:
            printerr(str)
        
        
    ## This attempts to replicate the "variable arguments"
    ## Assumes that the user will fill from left to right.
    ## Will break on the first UNDEFINED
    func to_clean_args(
        a = UNDEFINED.ref,
        b = UNDEFINED.ref,
        c = UNDEFINED.ref,
        d = UNDEFINED.ref,
        e = UNDEFINED.ref,
        f = UNDEFINED.ref,
        g = UNDEFINED.ref,
        h = UNDEFINED.ref,
        i = UNDEFINED.ref,
        j = UNDEFINED.ref
    ):
        var cleaned = []
    
        for arg in [a,b,c,d,e,f,g,h,i,j]:
            if arg is UNDEFINED: 
                break
            cleaned.append(arg)
            
        return cleaned
        
    func set_dict_deep(dict:Dictionary, paths:Array, value):
        var curr = dict
        var size = paths.size()
        for i in range(0,size):
            var path = paths[i]
            if path in curr:
                curr = curr[path]
            elif i + 1 == size:
                curr[path] = value
            else:
                curr[path] = {}
                curr = curr[path]
                
    func is_array(thing, __UNUSED__ = null):
        var type = typeof(thing)
        return type <= TYPE_PACKED_COLOR_ARRAY and type >= TYPE_ARRAY
        
    func is_string(thing, __UNUSED__ = null):
        return thing is String or thing is StringName
    
    func is_int_like(tmp):
        return (tmp is String and tmp.is_valid_int()) or (tmp is int)
        
    func is_number(a = null, _UNUSED_= null):
        return a is int or a is float
        
    func is_empty(value, __UNUSED__ = null):
        return size(value) <= 0
        
    func size(thing, __UNUSED__ = null):
        if is_array(thing) or thing is Dictionary:
            return thing.size()
        elif GD_.is_string(thing):
            return thing.length()
        elif thing is Object:
            if thing.has_method('length'):
                return thing.length()
            elif thing.has_method('size'):
                return thing.size()
            elif GD_.is_custom_iterator(thing):
                gd_warn("GD_.size received a custom iterator that doesnt implement size or length. This will be expensive to calculate")
                var ctr = 0
                for i in thing: 
                    ctr += 1
                return ctr
        gd_warn("GD_.size received a non-collection type value")
        return 0
        
    ## Splits the string into paths
    func string_to_path(str: String):
        var path = []
        for result in string_to_path_rx.search_all(str):
            var key = result.get_string(&"key")
            var first_char = key[0] if key and key != "[]" else null
            
            match(first_char):
                '"':
                    path.append(key.substr(1,key.length() - 2))
                "'":
                    path.append(key.substr(1,key.length() - 2))
                null:
                    path.append(&"")
                _:
                    if key.is_valid_int(): 
                        path.append(int(key))
                    elif key.is_valid_float(): 
                        path.append(float(key))
                    else: 
                        path.append(key)
        
        return path
        
    func to_number(value, _UNUSED_ = null): 
        if is_number(value):
            return value
        elif GD_.is_string(value) and value.is_valid_float():
            return float(str(value))
        return NAN
        
    func to_finite(value, _UNUSED_ = null): 
        if is_number(value):
            # See https://docs.godotengine.org/en/stable/classes/class_int.html
            var max_int_64 = 9223372036854775807
            if INF == value:
                return max_int_64
            elif -INF == value:
                return -max_int_64
        var result = to_number(value)
        
        if is_nan(result):
            return 0
        return to_number(value)
                    
    
    ## Attempt to get an index from an array or retural the default (null)	
    func get_index(array:Array, index:int, default_value = null):
        if index >= 0 and index < array.size():
            return array[index]
        return default_value
    
    func get_prop(thing, path, default_value = null):
        var splits
        if path is String:
            var result = get_prop(thing, [path], null)
            if result:
                return result
            splits = string_to_path(path)
        elif path is Array:
            splits = path
        elif is_number(path):
            splits = [path]
        else:
            gd_warn("GD_.get_prop received a non-collection type PATH")
            return default_value
            
        if not(splits):
            return default_value
        
        var curr_prop = thing
        for split in splits:
            if curr_prop is Object:
                var innnn = split in curr_prop
                if split in curr_prop:
                    var attempt = curr_prop.get(split)
                    if attempt != null:
                        curr_prop = attempt
                        continue
                    else:
                        return null
                else:
                    return default_value # which is null
            if curr_prop is Dictionary:
                if split in curr_prop: 
                    curr_prop = curr_prop[split]
                    continue
                # As of 4.2 theres a bug where `&"" in {"":1}` results in a false
                # If we rewrap with str it becomes usable again
                # See https://github.com/godotengine/godot/issues/77894
                # See https://github.com/godotengine/godot/pull/70096
                elif split is StringName and str(split) in curr_prop: 
                    curr_prop = curr_prop[str(split)]
                    continue
                elif split is String and split.is_valid_int():
                    curr_prop = curr_prop[int(split)]
                    continue
                elif split is int and split in curr_prop:
                    curr_prop = curr_prop[split]
                    continue
                else:
                    return default_value # which is null
            if curr_prop is Array \
                and is_int_like(split) \
                and int(split) < curr_prop.size():
                    curr_prop = get_index(curr_prop,int(split))
                    continue
            
            # Expensive but atleast it follows, Lodash behavior
            gd_warn("Warning: '%s' accesses a non-`Object`'s property which is expensive (e.g. Vector2 is a non-Object). Consider a different strategy" % &":".join(splits))
            var expression = Expression.new()
            var payload = "item['%s']" % split
            var result = expression.parse(payload,["item"])
            
            if result == OK:
                var tmp = expression.execute([curr_prop])
                if not(expression.has_execute_failed()):
                    curr_prop = tmp
                    continue
                
            return default_value
        return curr_prop
        
    ## For functions with weird and special behaviors when used as n iteratee.
    func get_iteratee(callable: Callable):
        # These functions have weird lodash behaviors as iteratee's
        # Visit each function for an explanation
        match callable:
            GD_.take: return iteratee_drop_second_arg(GD_.take)
            GD_.every: return iteratee_drop_second_arg(GD_.every)
        return callable
        
    ## Some iteratees completely drop the second argument when used in a map
    ## For example: 
    ##
    ## _.map([[1, 2, 3], [4, 5, 6], [7, 8, 9]], _.take)
    ## _.mapValues({a:[1, 2, 3], b:[4, 5, 6], c:[7, 8, 9]},_.take)
    ## 		vs
    ## _.map([[1, 2, 3], [4, 5, 6], [7, 8, 9]], (a,b)=> _.take(a,b))
    ## _.mapValues({a:[1, 2, 3], b:[4, 5, 6], c:[7, 8, 9]},(a,b) => _.take(a,b))
    func iteratee_drop_second_arg(callable:Callable):
        return func (arg1, _UNUSED_):
            return callable.call(arg1, null)
            
    func base_at(obj, arguments: Array):
        var array = []
        var paths
        for arg in arguments:
            if is_same(arg, _UNDEF_):
                continue
            for p in GD_.cast_array(arg):
                array.append(GD_.get_prop(obj, p))
        return array
            
    func base_chunk(array:Array,size=1): 
        # Thanks to cyberreality for the quick code they offered to the 
        # community. https://www.reddit.com/r/godot/comments/e6ae27/comment/f9p3c2e/?utm_source=share&utm_medium=web2x&context=3
        var new_array = []
        var i = 0
        var j = -1
        for item in array:
            if i % size == 0:
                new_array.append([])
                j += 1
            new_array[j].append(item)
            i += 1
        return new_array
    
    func base_compact(array:Array):
        var new_array = []
        for item in array:
            if item:
                new_array.append(item)
        return new_array
        
    func base_concat(array:Array, arguments:Array):
        var new_array = []
        new_array.append_array(array)
        for arg in arguments:
            # stop after first occurence of _UNDEF_
            if is_same(arg,_UNDEF_):
                break
            if arg is Array:
                new_array.append_array(arg)
            else:
                new_array.append(arg)
        return new_array
        
    func base_difference(array_left:Array, array_right:Array): 	
        var new_array = []
        new_array.append_array(array_left)
        
        for array_item_2 in array_right:
            new_array.erase(array_item_2)
            
        return new_array

    func base_difference_by(array_left, array_right, iteratee = identity): 
        var iter_func = iteratee(iteratee)
        
        # new return array
        var new_array = []
        
        # store processed keyes here
        var keys_to_remove_map = {}
        for array_item_2 in array_right:
            keys_to_remove_map[iter_func.call(array_item_2, null)] = true
            
        var array_right_max = array_left.size()
        
        for left_item in array_left:
            var left_key = iter_func.call(left_item, null)
            if not(keys_to_remove_map.has(left_key)):
                new_array.append(left_item)
                
        return new_array
        
    func base_some(collection, iteratee = null): 
        if not(GD_._is_collection(collection)):
            gd_warn("GD_.some received a non-collection type value")
            return null
            
        var iter_func = iteratee(iteratee)
        for key in keyed_iterable(collection):
            if iter_func.call(collection[key],key):
                return true
        return false
        
    func base_constant(value = null, _UNUSED_ = null):
        return func (a=_UNDEF_,b=_UNDEF_,c=_UNDEF_,d=_UNDEF_,e=_UNDEF_,f=_UNDEF_,g=_UNDEF_,h=_UNDEF_,i=_UNDEF_,j=_UNDEF_): 
            return value
        
    func base_unique_id(prefix=&""): 
        id_ctr += 1
        return str(prefix,id_ctr)
        
    func base_before(up_to_count, callable:Callable): 
        # A zero or an invalid count is the same as a noop
        if !up_to_count or is_nan(up_to_count):
            return GD_.noop
            
        var id = base_unique_id("before")
        callable_trackers[id] = {"i":0,"v":null}
        var fn = func ():
            if callable_trackers[id].i < up_to_count:
                callable_trackers[id].v = callable.call()
                callable_trackers[id].i += 1
            return callable_trackers[id].v
        return fn
    
    func base_after(after_count, callable:Callable): 
        # A zero or invalid count is the same as not limiting the callable
        if !after_count or is_nan(after_count):
            return callable
            
        var id = base_unique_id("after")
        callable_trackers[id] = {"i":0}
        var fn = func ():
            if callable_trackers[id].i >= after_count:
                return callable.call()
            callable_trackers[id].i += 1
        return fn
        
    func matches_property(string:String, v):
        return func (value, _unused = null):
            return GD_.get_prop(value,string) == v
        
    func matches(dict:Dictionary) -> Callable:
        return func (value, _unused = null):
            var found = true
            for key in dict:
                var prop = value.get(key)
                found = found and dict[key] == prop
            return found
            
    func property(path):
        var splits
        if path is String:
            splits = path.split(&":")
        elif path is Array:
            splits = path
        else:
            gd_warn("GD_.property received a non-collection type value")
            return null
            
        return func (value, _unused = null):
            return GD_.get_prop(value, path)
            
    func identity(value, _unused = null): 
        return value
        
    func iteratee(iteratee_val):
        if is_same(iteratee_val, _UNDEF_):
            return identity
        match typeof(iteratee_val):
            TYPE_DICTIONARY:
                return matches(iteratee_val)
            TYPE_STRING:
                return property(iteratee_val)
            TYPE_ARRAY:
                var prop = GD_.get_prop(iteratee_val,["0"])
                var val = GD_.get_prop(iteratee_val,["1"])
                return matches_property(prop,val)
            TYPE_NIL:
                return identity
            TYPE_CALLABLE:
                return GD_.__INTERNAL__.get_iteratee(iteratee_val)
                    
            _:
                gd_warn("GD_.find called with unsupported signature %s. See docs for more info" % iteratee)
        return null
        
    func keyed_iterable(thing, from_index = 0):
        if GD_.is_array_like(thing) or GD_.is_string(thing):
            var size = GD_.size(thing)
            if from_index >= 0:
                var array = range(from_index, size)
                return array
            return range(size).slice(size + from_index)
        if thing is Dictionary:
            var keys =  thing.keys()
            if from_index > 0:
                return keys.slice(from_index)
            elif from_index < 0:
                return keys.slice(thing.size() + from_index)
            else: 
                return keys
            
        gd_warn("keyed_iterable received a non-collection")
        return []
        
    
"""
INTERNAL STUFF
"""
    
static func _is_collection(item):
    return GD_.is_array_like(item) or item is Dictionary or GD_.is_string(item)
    
static func _is_not_null_arg(i,_i):
    return not(is_same(i, _UNDEF_))
    
static func not_implemented():  
    assert(false, "Not implemented yet. Do you need this function? If so, open an issue and I will prioritize it")

## Ensures that when it iterates through the item, it always iterates via keys
## This does not have a lodash equivalent	
static func keyed_iterable(thing, from_index = 0):
    return __INTERNAL__.keyed_iterable(thing, from_index)
