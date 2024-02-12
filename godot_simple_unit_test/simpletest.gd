@icon("res://godot_simple_unit_test/ui/icon_test.png")
extends Node

## Base class that all SimpleTests should extend from.
## This cannot be run by itself
class_name SimpleTest

var SimpleTest_LineItemTscn = preload("res://godot_simple_unit_test/ui/simpletest_line_item.tscn")

const EMPTY_ARRAY = []

signal on_finished_full_suite_run()

"""
######################
## Expect Functions ##
######################
"""
func expect(value)->SimpleTest_ExpectBuilder:
	return SimpleTest_ExpectBuilder.new(self,value)
	
	
func expect_orphan_nodes(n):
	Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT) == n
	
	
func expect_no_orphan_nodes():
	expect_orphan_nodes(0)
	
	
## Call to force a test to fail. 
func expect_fail(description = &"Forced failure invoked"):
	__append_error(description)
	
## Overrides the displayed test name. This is optional
func test_name(override_test_name:String):
	__run_state.transient.override_test_name = override_test_name

"""
//////////////////////////stub//
// Some Utility Functions //
////////////////////////////
"""

func stub():
	return SimpleTest_Stub.new()
	
"""
////////////////////
// Internal Stuff //
////////////////////
"""
class Run_State:
	var completed_count:int = 0
	var expected_count:int = 0
	var transient = Run_State_Transient.new()


class Run_State_Transient:
	var override_test_name:String = &""


var _ln_item
var _case_item
var _errors:Array[String]
## Only used for displaying purposes
var _curr_test_name = null

## Used in testing only
var _test_case_line_item_map = {}
var _runner

## All test cases
var _cases
## All tests cases that can be executed (solo and not skipped)
var _cases_runnable
## All solo test cases
var _cases_solo
## All skipped test cases
var _cases_skip
## All failed test runs (populated per run)
var _cases_failed
"""
NOTE: This _has_ to be overriden by runner
"""
func _enter_tree():
	pass


func _ready():
	__load_test_cases()

	var request_to_run_as_solo_suite = GD_.some(_cases,"solo_suite")
	var request_to_skip_suite = GD_.some(_cases,"skip_suite")
	owner.register_test(self,request_to_run_as_solo_suite, request_to_skip_suite)
	
## Override to run code before any of the tests in this suite
func _before():
	pass
	
	
func _before_each():
	pass
	
	
## Override to run code after each test case
func _after():
	pass
	
	
## Override to run code after all the tests have been run
func _after_each():
	pass
	

func __on_test_initialize(runner:SimpleTest_Runner):
	_ln_item = SimpleTest_LineItemTscn.instantiate()
	_ln_item.set_runner(runner)
	_ln_item.description = name

	_ln_item.status = &"PASS"
	_ln_item.ready.connect(__on_main_line_item_ready, Object.CONNECT_ONE_SHOT)
	
	_runner = runner
	_runner.add_block(_ln_item)
	
	
var __run_state:Run_State
func __set_run_state(expected_count:int):
	__run_state = Run_State.new()
	__run_state.expected_count = expected_count


func __on_main_line_item_ready():
	_ln_item.rerunButton.show()
	_ln_item.rerunButton.__method_name = "__run_all_tests"
	_ln_item.rerunButton.__test = self

	__set_run_state(_cases_runnable.size())
	
	_cases_failed = []
	for case in _cases:
		var case_ln_item = SimpleTest_LineItemTscn.instantiate()
		case_ln_item.set_runner(_runner)
		_test_case_line_item_map[case.fn] = case_ln_item
		
		case_ln_item.case = case
		case_ln_item.description = case.name
		case_ln_item.ready.connect(
			func(): 
				case_ln_item.rerunButton.show()
				case_ln_item.rerunButton.__method_name = case.fn
				case_ln_item.rerunButton.__case = case
				case_ln_item.rerunButton.__test = self
		, Object.CONNECT_ONE_SHOT)
		
		_ln_item.add_block(case_ln_item)
		
		await case_ln_item.ready
		__run_test(case, case_ln_item)
		
		var has_error = _errors.size() > 0
		if has_error:
			_cases_failed.append(case)
			
		
	on_finished_full_suite_run.emit()
	
	_ln_item.status = &"FAIL" if _cases_failed.size() else &"PASS"
	
	# default to collapsed if no failures
	# else open
	_ln_item.set_collapse(not(_cases_failed))
	
	_ln_item.description = &"{name} ({passing}/{total} passed)".format({
		"name":name,
		"passing": _cases_runnable.size() - _cases_failed.size(),
		"total": _cases_runnable.size(),
	})
		
func __run_test(case, ln_item):
	"""
	this is a transient field. this only works if running sequentially
	"""
	_errors = []
	case.last_run_errors = []
	
	if __run_state.completed_count == 0:
		_before()
		
	if case.skipped:
		__run_test_skip(case, ln_item)
	else:
		__run_test_run(case, ln_item)
		__run_state.completed_count += 1
		
	if __run_state.completed_count == __run_state.expected_count:
		_after()
		
	case.last_run_errors.append_array(_errors)
		
	"""
	Update test name - TODO move this from function to param
	"""
	if __run_state.transient.override_test_name:
		ln_item.description = __run_state.transient.override_test_name
		
		
	"""
	Cleanup for the next test run
	"""
	__run_state.transient.override_test_name = &""
	_curr_test_name = null
	
	
func __run_test_skip(case, ln_item):
	"""
	Update the GUI elements. The results of the test are collected at
	_errors.
	"""
	# Update the pass - fail
	ln_item.status = &"SKIPPED"
	ln_item.clear_blocks()
	
			
func __run_test_run(case, ln_item):
	var method_name = case.fn
	
	
	# Only used for debugging purposes
	_curr_test_name = method_name
		
	"""
	Perform the actual test
	"""
	_before_each()
	
	var args = []
	
	for arg in GD_.cast_array(case.args):
		if not(SimpleTest_Utils.argument_keywords.has(arg.name)):
			printerr(
				"Unsupported test argument({arg}) provided for {method} ".format({
						"arg":arg.name,
						"method": method_name
					}))
		args.append(null)		
	
	self.callv(method_name, args)
	
	_after_each()
		
	"""
	Update the GUI elements. The results of the test are collected at
	_errors.
	"""
	var has_failed = len(_errors) > 0

	# Update the pass - fail
	ln_item.status = &"FAIL" if has_failed else (
		&"PASS (SOLO)" if case.solo else &"PASS"
	)
	ln_item.clear_blocks()
	for f in _errors:
		var f_line_item = SimpleTest_LineItemTscn.instantiate()
		f_line_item.set_runner(_runner)
		f_line_item.description = f
		ln_item.add_block(f_line_item)
		
	
func __run_single_test(method_name,ln_item):
	__set_run_state(1)
	__run_test(method_name,ln_item)
	
	
func __run_all_tests():
	_ln_item.clear_blocks()
	__on_main_line_item_ready()
	

func __load_test_cases():
	_cases = SimpleTest_Utils.get_test_cases(self)
	_cases_solo = GD_.filter(_cases,'solo')
	
	if _cases_solo.size():
		for case in _cases:
			case.skipped = not(case.solo)
	
	_cases_skip = GD_.filter(_cases,'skipped')
	
	_cases_runnable = _cases_solo if _cases_solo.size() else _cases
	_cases_runnable = GD_.filter(_cases,{'skipped':false})

func __assert(result:bool, description, default):
	if !result:
		_errors.append(description if description else default)
		
		
func __append_error(description):
	_errors.append(description)
	
