# Base class  for storing functions that have the same name as globalscope types
# And other random utility functions


# Use this to differentiate betwen default null
# and actual null values. Do not use outside of this class.
class UNDEFINED: 
    static var ref:UNDEFINED
    
    func _init():
        ref = self
        
static var static_self = self

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
    
    var char_code_reference = "azAZ".to_utf8_buffer()
    var key_a = char_code_reference[0]
    var key_z = char_code_reference[1]
    var key_A = char_code_reference[2]
    var key_Z = char_code_reference[3]
    
    """
    The subsection BELOW is dedicated to building the regex used in GD_.words
    """
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
    var rx_words = RegEx.create_from_string(
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
    """
    The subsection ABOVE is dedicated to building the regex used in GD_.words
    """
    
    
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
                
    func base_is_array(thing, __UNUSED__ = null):
        var type = typeof(thing)
        return type <= TYPE_PACKED_COLOR_ARRAY and type >= TYPE_ARRAY

    func is_int_like(tmp):
        return (tmp is String and tmp.is_valid_int()) or (tmp is int)
        
    func base_is_number(a = null, _UNUSED_=null):
        return a is int or a is float
        
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
                    
    
    ## Attempt to get an index from an array or retural the default (null)	
    func get_index(array:Array, index:int, default_value = null):
        if index >= 0 and index < array.size():
            return array[index]
        return default_value
    
    func base_get_prop(thing, path, default_value = null):
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
    ##
    func get_iteratee(callable: Callable):
        """
        FAQ Portion:
        Q: Why reference a method by index e.g. 
           e.g. GD_["words"] instead of GD_.words
        A: To circumvent GD's type safety where it starts throwing errors
        if a rootscript references a member from its inheritors 
        (
            yes i know this is bad design but id rather have this than surface
            implementation details to consumers
        )
        
        """
        if callable in [GD_["words"],GD_["take"],GD_["every"]]:
            return iteratee_drop_second_arg(callable)
        
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
                array.append(base_get_prop(obj, p))
        return array
        
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
    
    func matches_property(string:String, v):
        return func (value, _unused = null):
            return base_get_prop(value,string) == v
        
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
            return base_get_prop(value, path)
            
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
                var prop = base_get_prop(iteratee_val,["0"])
                var val = base_get_prop(iteratee_val,["1"])
                return matches_property(prop,val)
            TYPE_NIL:
                return identity
            TYPE_CALLABLE:
                return get_iteratee(iteratee_val)
                    
            _:
                gd_warn("GD_.find called with unsupported signature %s. See docs for more info" % iteratee)
        return null

"""
INTERNAL STUFF
"""
static func _is_not_null_arg(i,_i):
    return not(is_same(i, _UNDEF_))
    
static func not_implemented():  
    assert(false, "Not implemented yet. Do you need this function? If so, open an issue and I will prioritize it")

## Ensures that when it iterates through the item, it always iterates via keys
## This does not have a lodash equivalent	
static func keyed_iterable(thing, from_index = 0):
    return __INTERNAL__.keyed_iterable(thing, from_index)
