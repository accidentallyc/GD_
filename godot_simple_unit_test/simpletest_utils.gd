class_name SimpleTest_Utils

class Case:
	var skipped:bool
	var solo:bool
	var solo_suite:bool
	var skip_suite:bool
	var name:String
	var fn:String
	var args:Array
	var last_run_errors:Array


static func get_test_cases(script):
	var cases = []
	for method in script.get_method_list():
		var method_name = method.name
		var args = method.args
		if _is_method_test_case(method):
				var case := Case.new()
				case.name = method.name.replace(&"_",&" ")
				case.fn = method.name
				case.args = args
				
				var arg_groups = GD_.group_by(args,'name')
				case.skipped = arg_groups.has('_skip')
				case.solo = arg_groups.has('_solo')
				case.solo_suite = arg_groups.has('_solo_suite')
				case.skip_suite = arg_groups.has('_skip_suite')
				cases.append(case)
	return cases


static func _is_method_test_case(method) ->bool:
	var method_name = method.name
	return method.flags == METHOD_FLAG_NORMAL \
				and method_name != &"test_name" \
				and ( \
					method_name.begins_with(&"it") \
					or method_name.begins_with(&"should") \
					or method_name.begins_with(&"test") \
				)

static var argument_keywords = {
	"_skip": true,
	"_solo": true,
	"_solo_suite": true,
	"_skip_suite": true
}
