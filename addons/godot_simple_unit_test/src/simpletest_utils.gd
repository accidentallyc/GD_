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
				
				var arg_groups = GD__.group_by(args,'name')
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
	
static func type_to_str(type:int):
	match type:
		TYPE_NIL:
			return "null"
		TYPE_BOOL:
			return "bool"
		TYPE_INT:
			return "int"
		TYPE_FLOAT:
			return "float"
		TYPE_STRING:
			return "String"
		TYPE_VECTOR2:
			return "Vector2"
		TYPE_VECTOR2I:
			return "Vector2i"
		TYPE_RECT2:
			return "Rect2"
		TYPE_RECT2I:
			return "Rect2i"
		TYPE_VECTOR3:
			return "Vector3"
		TYPE_VECTOR3I:
			return "Vector3i"
		TYPE_TRANSFORM2D:
			return "Transform2D"
		TYPE_VECTOR4:
			return "Vector4"
		TYPE_VECTOR4I:
			return "Vector4i"
		TYPE_PLANE:
			return "Plane"
		TYPE_QUATERNION:
			return "Quaternion"
		TYPE_AABB:
			return "AABB"
		TYPE_BASIS:
			return "Basis"
		TYPE_TRANSFORM3D:
			return "Transform3D"
		TYPE_PROJECTION:
			return "Projection"
		TYPE_COLOR:
			return "Color"
		TYPE_STRING_NAME:
			return "StringName"
		TYPE_NODE_PATH:
			return "NodePath"
		TYPE_RID:
			return "RID"
		TYPE_OBJECT:
			return "Object"
		TYPE_CALLABLE:
			return "Callable"
		TYPE_SIGNAL:
			return "Signal"
		TYPE_DICTIONARY:
			return "Dictionary"
		TYPE_ARRAY:
			return "Array"
		TYPE_PACKED_BYTE_ARRAY:
			return "PackedByteArray"
		TYPE_PACKED_INT32_ARRAY:
			return "PackedInt32Array"
		TYPE_PACKED_INT64_ARRAY:
			return "PackedInt64Array"
		TYPE_PACKED_FLOAT32_ARRAY:
			return "PackedFloat32Array"
		TYPE_PACKED_FLOAT64_ARRAY:
			return "PackedFloat64Array"
		TYPE_PACKED_STRING_ARRAY:
			return "PackedStringArray"
		TYPE_PACKED_VECTOR2_ARRAY:
			return "PackedVector2Array"
		TYPE_PACKED_VECTOR3_ARRAY:
			return "PackedVector3Array"
		TYPE_PACKED_COLOR_ARRAY:
			return "PackedColorArray"
		TYPE_MAX:
			return "Represents the size of the Variant.Type enum"
	return "typeof(%s) " % type
