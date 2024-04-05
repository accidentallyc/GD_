extends "./GD_number.gd"


"""
CATEGORY: MATH
"""
static func add(a=0, b=0, c=0): not_implemented()

#static func ceil(a=0, b=0, c=0): not_implemented()

static func divide(a=0, b=0, c=0): not_implemented()

## Computes number rounded down to precision. This uses Godot's floor
## internally but precision can be added.
##
##
## Arguments
##      number (number): The number to round down.
##      [precision=0] (number): The precision to round down to.
## Returns
##      (number): Returns the rounded down number.
## Example
##      GD_.floor(4.006)
##      # => 4
##       
##      GD_.floor(0.046, 2)
##      # => 0.04
##       
##      GD_.floor(4060, -2)
##      # => 4000
static func floor(number, precision = null):
    var scale = pow(10.0, default_to(precision,0))
    return __floor(number * scale) / scale

#static func max(a=0, b=0, c=0): not_implemented()

static func max_by(a=0, b=0, c=0): not_implemented()

static func mean(a=0, b=0, c=0): not_implemented()

static func mean_by(a=0, b=0, c=0): not_implemented()

#static func min(a=0, b=0, c=0): not_implemented()

static func min_by(a=0, b=0, c=0): not_implemented()

static func multiply(a=0, b=0, c=0): not_implemented()

#static func round(a=0, b=0, c=0): not_implemented()

static func subtract(a=0, b=0, c=0): not_implemented()

static func sum(a=0, b=0, c=0): not_implemented()

static func sum_by(a=0, b=0, c=0): not_implemented()


