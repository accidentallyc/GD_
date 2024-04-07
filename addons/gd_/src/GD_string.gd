extends "./GD_lang.gd"

"""
CATEGORY: STRING
"""

static func camel_case(): not_implemented()
static func capitalize(): not_implemented()
static func deburr(): not_implemented()
static func ends_with(): not_implemented()
static func escape(): not_implemented()
static func escape_reg_exp(): not_implemented()
static func kebab_case(): not_implemented()

static func lower_case(str:String, _UNUSED_ = null): not_implemented()
    
    
static func lower_first(): not_implemented()
static func pad(): not_implemented()
static func pad_end(): not_implemented()
static func pad_start(): not_implemented()

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func parse_int(): not_implemented() 

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func repeat(): not_implemented() 
static func replace(): not_implemented()
static func snake_case(): not_implemented()

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func split(): not_implemented() 
static func start_case(): not_implemented()
static func starts_with(): not_implemented()

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func template(): not_implemented() 

## Wrapper for "string".to_lower().
## Arguments
##      [string=''] (string): The string to convert.
## Returns
##      (string): Returns the lower cased string.
## Example
##      GD_.to_lower('--Foo-Bar--');
##      # => '--foo-bar--'
##       
##      GD_.to_lower('fooBar');
##      # => 'foobar'
##       
##      GD_.to_lower('__FOO_BAR__');
##      # => '__foo_bar__'
## Notes
##     >> Though similar this is different from GD_.lower_case
static func to_lower(a:String, _UNUSED_ = null): 
    return a.to_lower()
 
## Wrapper for "string".to_upper().
## Arguments
##      [string=''] (string): The string to convert.
## Returns
##      (string): Returns the lower cased string.
## Example
##      GD_.to_upper('--Foo-Bar--');
##      # => '--foo-bar--'
##       
##      GD_.to_upper('fooBar');
##      # => 'foobar'
##       
##      GD_.to_upper('__FOO_BAR__');
##      # => '__foo_bar__'
## Notes
##     >> Though similar this is different from GD_.upper_case   
static func to_upper(a:String, _UNUSED_ = null):
    return a.to_upper()

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func trim(): not_implemented() 

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func trim_end(): not_implemented() 

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func trim_start(): not_implemented() 
static func truncate(): not_implemented()
static func unescape(): not_implemented()
static func upper_case(): not_implemented()
static func upper_first(): not_implemented()


## Splits string into an array of its words.
## 
## Arguments
##      [string=''] (string): The string to inspect.
##      [pattern] (RegExp|string): The pattern to match words.
## Returns
##      (Array): Returns the words of string.
## 
## Example
##      GD_.words('fred, barney, & pebbles');
##      # => ['fred', 'barney', 'pebbles']
##       
##      GD_.words('fred, barney, & pebbles', "[^, ]+");
##      # => ['fred', 'barney', '&', 'pebbles']
## Notes
##      >> Regarding the default regex used
##          This uses a less powerful version of lodash's regex but should
##          match most uses cases. Please open a ticket if you find any
##          cases where the function does not correctly split it into words
static func words(str, pattern = null): 
    var rx:RegEx = __INTERNAL__.rx_words 
    if pattern != null: 
        rx = pattern if pattern is RegEx else RegEx.create_from_string(pattern)
    
    var results = []
    for result in rx.search_all(str):
        results.push_back(result.get_string())
    return results
