@icon("res://addons/godot_simple_unit_test/src/ui/icon_runner.png")

@tool
extends SimpleTest

## Root of a SimpleTest Scene. Assign this as the root node. 
## Do not extend this. Use as is.
class_name SimpleTest_Runner

static var SimpleTest_CanvasTscn := preload("./ui/simpletest_canvas.tscn")

var _tests = []
var _canvas
var _solo_tests = []
var _has_solo_test_suites = false


func _ready():
	_canvas = SimpleTest_CanvasTscn.instantiate()
	_canvas.ready.connect(func (): _begin_test_runs())
	add_child(_canvas)
	
	
func _begin_test_runs():
	var entries = GD__.filter(_tests,"solo") if _has_solo_test_suites else _tests
	entries = entries.filter(func(c): return !c.skip)
	for entry in entries:
		entry.test.__on_test_initialize(self)
	
	
func register_test(test:SimpleTest, request_solo_suite:bool,request_to_skip_suite:bool):
	_has_solo_test_suites = _has_solo_test_suites or request_solo_suite
	
	if request_solo_suite and request_to_skip_suite:
		printerr("Test(%s) has both solo and skip controls. SKIP will be ignored" % test.name)
		request_to_skip_suite = false
		
	_tests.append({
		"test":test,
		"solo": request_solo_suite,
		"skip": request_to_skip_suite
	})


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
