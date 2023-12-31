@icon("res://addons/godot_simple_unit_test/src/ui/icon_runner.png")

@tool
extends SimpleTest

## Root of a SimpleTest Scene. Assign this as the root node. 
## Do not extend this. Use as is.
class_name SimpleTest_Runner

signal runner_ready(SimpleTest_Runner)

static var SimpleTest_CanvasTscn := preload("./ui/simpletest_canvas.tscn")

var _canvas

func _ready():
	_canvas = SimpleTest_CanvasTscn.instantiate()
	_canvas.ready.connect(func (): runner_ready.emit(self))
	add_child(_canvas)
	

"""
#########################
# Warning Handling Code #
#########################
"""
func _enter_tree():
	child_entered_tree.connect(func(_dummy): update_configuration_warnings())


func _get_configuration_warnings():
	if !(owner == null or owner == self):
		return ["SimpleTest_Runner must be a root node"]
	else:
		return []
	
func add_block(block:Control):
	_canvas.add_block.call_deferred(block)
