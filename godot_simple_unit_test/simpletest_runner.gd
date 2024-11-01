@icon("res://godot_simple_unit_test/ui/icon_runner.png")

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
var _should_show_passed_tests = false

signal on_toggle_show_passed_tests

func _ready():
	if Engine.is_editor_hint():
		return
		
	_canvas = SimpleTest_CanvasTscn.instantiate()
	_canvas._runner = self
	_canvas.ready.connect(func (): _begin_test_runs())
	add_child(_canvas)
	
	
func _begin_test_runs():
	var entries = GD_.filter(_tests,"solo") if _has_solo_test_suites else _tests
	entries = entries.filter(func(c): return !c.skip)
	
	var failed_test_count = 0
	var total_test_count = 0
	for entry in entries:
		var test = entry.test
		test.__on_test_initialize(self)
		await test.on_finished_full_suite_run
		total_test_count += test._cases_runnable.size()
		failed_test_count += test._cases_failed.size()
		
	if total_test_count == 0:
		_canvas.container.description = "No tests yet. Add a new node of type SimpleTest to start 😁"
		return
		
	#@TODO unhide this, and make it rerun everything
	_canvas.container.set_runner(self)
	_canvas.container.rerunButton.hide() 
	_canvas.container.status = &"FAIL" if failed_test_count else &"PASS"
	_canvas.container.description = &"{name} ({passing}/{total} passed)".format({
		"name":name,
		"passing":  total_test_count - failed_test_count,
		"total": total_test_count,
	})
		
		
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
