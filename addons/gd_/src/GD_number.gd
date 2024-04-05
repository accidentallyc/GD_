extends "./GD_util.gd"


"""
CATEGORY: NUMBER
"""

#static func clamp(a=0, b=0, c=0): not_implemented()

static func in_range(a=0, b=0, c=0): not_implemented()

## Produces a random number between the inclusive `lower` and `upper` bounds.
## If only one argument is provided a number between `0` and the given number
## is returned. If `floating` is `true`, or either `lower` or `upper` are
## floats, a floating-point number is returned instead of an integer.
## 
## Arguments
##      [lower=0] (number): The lower bound.
##      [upper=1] (number): The upper bound.
##      floating (bool): Specify returning a floating-point number.
## Returns
##     (number): Returns the random number.
## Example
##      random(0, 5)
##      # => an integer between 0 and 5
##
##      random(5)
##      # => also an integer between 0 and 5
##
##      random(5, true)
##      # => a floating-point number between 0 and 5
##
##      random(1.2, 5.2)
##      # => a floating-point number between 1.2 and 5.2
## Notes
##     >> @TODO guarded method by map, every, filter, mapValues, reject, some
static func random(lower=0, upper=0, floating:bool=false):
    # @TODO guarded method by map, every, filter, mapValues, reject, some
    if not floating:
        if upper is bool:
            floating = upper
            upper = null
        elif lower is bool:
            floating = lower
            lower = null
        
    if not lower or lower != lower and not upper:
        lower = 0
        upper = 1
    else:
        upper = to_finite(upper)
    
    if lower > upper:
        var temp = lower
        lower = upper
        upper = temp
        
    if floating or lower is float or upper is float:
        var rand = randf()
        var rand_length = str(rand).length() - 1
        return float(min(lower + rand * (upper - lower + (1.0 * pow(10, 1))), upper))
    return int(lower + floor(randf() * (upper - lower + 1)))
