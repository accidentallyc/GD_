# Base class  for storing functions that have the same name as globalscope types
# And other random utility functions

static var static_self = self
static var _EMPTY_ARRAY_ = []

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

static func _get_callable_result(callable:Callable):
    return callable.call()
    
    
## Utility class to support the "ellipsis args" that
## Lodash dash into something that can be consumed by Godot
class __INTERNAL_ARGS__:
    var last_item 
    var all = []
    
    func size() -> int:
        return all.size()
    
    func last_is_iteratee(raw_args:Array, default_last_item = null):
        last_item = default_last_item
        for arg in raw_args:
            if GD_UNDEF.is_undefined(arg):
                break
            all.append(arg)
        last_item = all.pop_back()
    
    func last_is_func(raw_args:Array, default_last_item = null):
        last_item = default_last_item
        for arg in raw_args:
            if arg is Callable:
                last_item = arg
                break
            if GD_UNDEF.is_undefined(arg):
                break
            all.append(arg)
            
## Wrapping it in a class o we can hide the implementation from being visible
## when accessing GD_.
class __INTERNAL__:
    static var _GDref = preload("res://addons/gd_/src/GD_.gd")
            
    """
    Function useful for complex initializations without
    exposing implementation
    """
    static func _get_callable_result(callable:Callable): 
        return callable.call()
        
    # Used for testing purposes
    static var last_warning
    static var is_warning_enabled = true
    static var id_ctr = 0
    
    static var char_code_reference = "azAZ".to_utf8_buffer()
    static var key_a = char_code_reference[0]
    static var key_z = char_code_reference[1]
    static var key_A = char_code_reference[2]
    static var key_Z = char_code_reference[3]
    
    """
    The subsection BELOW is dedicated to building the regex used in GD_.words
    """
    static var rx_words = _get_callable_result(func ():
            var rx_words_postfixes = "|".join([
                '(\'[dD])', 
                '(\'[lL][lL])', 
                '(\'[mM])', 
                '(\'[rR][eE])', 
                '(\'[sS])', 
                '(\'[tT])', 
                '(\'[vV][eE])',
            ])
            var rx_words_ordinals = "|".join([
                '[sS][tT]', '[nN][dD]', '[rR][dD]', '[tT][hH]'
            ])
            var rx_words_args = {
                "postfixes":rx_words_postfixes,
                "ordinals": rx_words_ordinals
            }
            return RegEx.create_from_string(
                "|".join([
                    # Numbers
                    "([0-9]+({ordinals})?)".format(rx_words_args),
                    # Captilized words
                    "(\\p{Lu}{1}\\p{Ll}+({postfixes})?)".format(rx_words_args),
                    # All capped words,
                    "(\\p{Lu}+(?!\\p{Ll}))({postfixes})?".format(rx_words_args),
                    # lowercase everything
                    "(\\p{Ll}+)({postfixes})?".format(rx_words_args),
                    # Emojis and other chars
                    "(\\p{So})"
                ])
            )
    )
    """
    The subsection ABOVE is dedicated to building the regex used in GD_.words
    """
    
    # Regex for converting string to path
    static var string_to_path_rx:RegEx = RegEx.create_from_string(
        str(
            "(\\[(?<key>[\\w\\s\'\"\\.]+)?\\])",
            "|",
            "(?<key>\'?[\\w\\s\\.]+\'?)",
            "|",
            "(?<key>\"?[\\w\\s\\.]+\"?)",
            )
    )
    
    
    # Keeps track of how many times
    # a specific function has been called
    # - Used in before and after trackers 
    static var callable_trackers = {}

    static func gd_warn(str:String):
        last_warning = str
        if is_warning_enabled:
            printerr(str)
        
        
    ## This attempts to replicate the "variable arguments"
    ## Assumes that the user will fill from left to right.
    ## Will break on the first GD_UNDEF
    static func to_clean_args(
        a = GD_UNDEF,
        b = GD_UNDEF,
        c = GD_UNDEF,
        d = GD_UNDEF,
        e = GD_UNDEF,
        f = GD_UNDEF,
        g = GD_UNDEF,
        h = GD_UNDEF,
        i = GD_UNDEF,
        j = GD_UNDEF
    ):
        var cleaned = []
    
        for arg in [a,b,c,d,e,f,g,h,i,j]:
            if GD_UNDEF.is_undefined(arg): 
                break
            cleaned.append(arg)
            
        return cleaned
        
    static func is_false(v): return not(v) or GD_UNDEF.is_undefined(v)
        
    static func set_dict_deep(dict:Dictionary, paths:Array, value):
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
                
    static func base_is_array(thing, __UNUSED__ = null):
        var type = typeof(thing)
        return type <= TYPE_PACKED_COLOR_ARRAY and type >= TYPE_ARRAY

    static func is_int_like(tmp):
        return (tmp is String and tmp.is_valid_int()) or (tmp is int)
        
    static func base_is_number(a = null, _UNUSED_=null):
        return a is int or a is float

    ## Splits the string into paths
    static func string_to_path(str: String):
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
                    
    
    ## Attempt to get an index from an array or retural the default (null)	
    static func get_index(array:Array, index:int, default_value = null):
        if index >= 0 and index < array.size():
            return array[index]
        return default_value
    
    static func base_get_prop(thing, path, default_value = null):
        var splits
        if path is String:
            var result = base_get_prop(thing, [path], null)
            if result:
                return result
            splits = string_to_path(path)
        elif path is Array:
            splits = path
        elif base_is_number(path):
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
    ## These functions are considered "guarded"
    static func get_iteratee(callable: Callable):
        """
        FAQ Portion:
        Q: Why use the _GDref
           e.g. _GDref.words vs GD_.words
        A: Because GD_ cannot handle circular references yet.
        See https://github.com/godotengine/godot-proposals/issues/1566
        """
        if callable in [
                _GDref.words,
                _GDref.take, 
                _GDref.take_right,
                _GDref.every
                ]:
            return iteratee_drop_second_arg(callable)
        
        return callable
        
    ## Some iteratees completely drop the second argument when used in a map
    ## For example: 
    ##
    ## _.map([[1, 2, 3], [4, 5, 6], [7, 8, 9]], _.take)
    ## _.mapValues({a:[1, 2, 3], b:[4, 5, 6], c:[7, 8, 9]},_.take)
    ##      vs
    ## _.map([[1, 2, 3], [4, 5, 6], [7, 8, 9]], (a,b)=> _.take(a,b))
    ## _.mapValues({a:[1, 2, 3], b:[4, 5, 6], c:[7, 8, 9]},(a,b) => _.take(a,b))
    static func iteratee_drop_second_arg(callable:Callable):
        return func (arg1, _UNUSED_):
            return callable.call(arg1, null)
            
    static func base_at(obj, arguments: Array):
        var array = []
        var paths
        for arg in arguments:
            if GD_UNDEF.is_undefined(arg):
                continue
            for p in _GDref.cast_array(arg):
                array.append(base_get_prop(obj, p))
        return array
        
    static func base_concat(array:Array, arguments:Array):
        var new_array = []
        new_array.append_array(array)
        for arg in arguments:
            # stop after first occurence of GD_UNDEF
            if GD_UNDEF.is_undefined(arg):
                break
            if arg is Array:
                new_array.append_array(arg)
            else:
                new_array.append(arg)
        return new_array
    
    static func matches_property(string:String, v):
        return func (value, _unused = null):
            return base_get_prop(value,string) == v
        
    static func matches(dict:Dictionary) -> Callable:
        return func (value, _unused = null):
            var found = true
            for key in dict:
                var prop = value.get(key)
                found = found and dict[key] == prop
            return found
            
    static func item_in(item, array:Array, comparator:Callable):
        for i in array:
            if comparator.call(i, item):
                return true
        return false
        
    static func property(path):
        var splits
        if path is String:
            splits = path.split(&":")
        elif path is Array:
            splits = path
        else:
            gd_warn("GD_.property received a non-collection type value")
            return null
            
        return func (value, _unused = null):
            return base_get_prop(value, path)
            
    static func iteratee(iteratee_val):
        var type = typeof(iteratee_val)
        if GD_UNDEF.is_undefined(iteratee_val) or type == TYPE_NIL:
            # @TODO move this to its own function
            return func identity(v,_v = null): return v # Identity
        match type:
            TYPE_DICTIONARY:
                return matches(iteratee_val)
            TYPE_STRING:
                return property(iteratee_val)
            TYPE_ARRAY:
                var prop = base_get_prop(iteratee_val,["0"])
                var val = base_get_prop(iteratee_val,["1"])
                return matches_property(prop,val)
            TYPE_CALLABLE:
                return get_iteratee(iteratee_val)
                    
            _:
                gd_warn("GD_.find called with unsupported signature %s. See docs for more info" % iteratee)
        return null
    
    static func get_max_size_of_all_arrays(arrays:Array):
        var max_size = 0
        for a in arrays:
            var tmp = a.size()
            if(tmp > max_size): max_size = tmp
        return max_size

"""
INTERNAL STUFF
"""
static func assert_resource_group():
    assert(GDInternal_ResourceGroup != null, """
        This function requires GDInternal_ResourceGroup to be autoloaded in. 
        Please re-enable the plugin or restart the editor.
    """)
    
static func not_implemented():  
    assert(false, "Not implemented yet. Do you need this function? If so, open an issue and I will prioritize it")
