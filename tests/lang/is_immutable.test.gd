extends SimpleTest

func it_correctly_identifies_pass_by_copy_or_by_reference():
	var cases =  {
		TYPE_NIL: make_TYPE_NIL,
		TYPE_BOOL: make_TYPE_BOOL,
		TYPE_INT: make_TYPE_INT,
		TYPE_FLOAT: make_TYPE_FLOAT,
		TYPE_STRING: make_TYPE_STRING,
		TYPE_VECTOR2: make_TYPE_VECTOR2,
		TYPE_VECTOR2I: make_TYPE_VECTOR2I,
		TYPE_RECT2: make_TYPE_RECT2,
		TYPE_RECT2I: make_TYPE_RECT2I,
		TYPE_VECTOR3: make_TYPE_VECTOR3,
		TYPE_VECTOR3I: make_TYPE_VECTOR3I,
		TYPE_TRANSFORM2D: make_TYPE_TRANSFORM2D,
		TYPE_VECTOR4: make_TYPE_VECTOR4,
		TYPE_VECTOR4I: make_TYPE_VECTOR4I,
		TYPE_PLANE: make_TYPE_PLANE,
		TYPE_QUATERNION: make_TYPE_QUATERNION,
		TYPE_AABB: make_TYPE_AABB,
		TYPE_BASIS: make_TYPE_BASIS,
		TYPE_TRANSFORM3D: make_TYPE_TRANSFORM3D,
		TYPE_PROJECTION: make_TYPE_PROJECTION,
		TYPE_COLOR: make_TYPE_COLOR,
		TYPE_STRING_NAME: make_TYPE_STRING_NAME,
		TYPE_NODE_PATH: make_TYPE_NODE_PATH,
		TYPE_RID: make_TYPE_RID,
		TYPE_OBJECT: make_TYPE_OBJECT,
		TYPE_CALLABLE: make_TYPE_CALLABLE,
		TYPE_SIGNAL: make_TYPE_SIGNAL,
		TYPE_DICTIONARY: make_TYPE_DICTIONARY,
		TYPE_ARRAY: make_TYPE_ARRAY,
		TYPE_PACKED_BYTE_ARRAY: make_TYPE_PACKED_BYTE_ARRAY,
		TYPE_PACKED_INT32_ARRAY: make_TYPE_PACKED_INT32_ARRAY,
		TYPE_PACKED_INT64_ARRAY: make_TYPE_PACKED_INT64_ARRAY,
		TYPE_PACKED_FLOAT32_ARRAY: make_TYPE_PACKED_FLOAT32_ARRAY,
		TYPE_PACKED_FLOAT64_ARRAY: make_TYPE_PACKED_FLOAT64_ARRAY,
		TYPE_PACKED_STRING_ARRAY: make_TYPE_PACKED_STRING_ARRAY,
		TYPE_PACKED_VECTOR2_ARRAY: make_TYPE_PACKED_VECTOR2_ARRAY,
		TYPE_PACKED_VECTOR3_ARRAY: make_TYPE_PACKED_VECTOR3_ARRAY,
		TYPE_PACKED_COLOR_ARRAY: make_TYPE_PACKED_COLOR_ARRAY
	}

	if GD_.is_version(">=4.3"):
		var TYPE_PACKED_VECTOR4_ARRAY = TYPE_PACKED_COLOR_ARRAY + 1
		cases[TYPE_PACKED_VECTOR4_ARRAY] = make_TYPE_PACKED_VECTOR4_ARRAY
	
	for type in cases:
		var factory = cases[type]
		var a = factory.call()
		var b = factory.call()
		var is_immutable = str(a) == str(b) and is_same(a,b)
		var result = GD_.is_immutable(a)
		var error_text = "immutable" if is_immutable else "mutable"

		expect(result).equal(is_immutable, "expected %s(%s) to be categorized as %s " % [type_string(type),type,error_text])
		
	var size = GD_.size(cases)
	expect(size).to.equal(TYPE_MAX, "There are only %s cases but theres a max of %s" % [size, TYPE_MAX])
	
	
func make_TYPE_NIL(): return null 
func make_TYPE_BOOL(): return false
func make_TYPE_INT(): return 1
func make_TYPE_FLOAT(): return 1.1
func make_TYPE_STRING(): return "foobar"
func make_TYPE_VECTOR2(): return Vector2.ONE
func make_TYPE_VECTOR2I(): return Vector2i.ONE
func make_TYPE_RECT2(): return Utils.rect2
func make_TYPE_RECT2I(): return Utils.rect2i
func make_TYPE_VECTOR3(): return Vector3.ONE
func make_TYPE_VECTOR3I(): return Vector3i.ONE
func make_TYPE_TRANSFORM2D(): return Transform2D()
func make_TYPE_VECTOR4(): return Vector4.ONE
func make_TYPE_VECTOR4I(): return Vector4i.ONE
func make_TYPE_PLANE(): return Plane()
func make_TYPE_QUATERNION(): return Quaternion()
func make_TYPE_AABB(): return AABB()
func make_TYPE_BASIS(): return Basis()
func make_TYPE_TRANSFORM3D(): return Transform3D()
func make_TYPE_PROJECTION(): return Projection()
func make_TYPE_COLOR(): return Color.ALICE_BLUE
func make_TYPE_STRING_NAME(): return StringName()
func make_TYPE_NODE_PATH(): return NodePath()
func make_TYPE_RID(): return RID()
func make_TYPE_OBJECT(): return Utils.node
func make_TYPE_CALLABLE(): return Callable()
func make_TYPE_SIGNAL(): return Signal()
func make_TYPE_DICTIONARY(): return Dictionary()
func make_TYPE_ARRAY(): return Array()
func make_TYPE_PACKED_BYTE_ARRAY(): return PackedByteArray()
func make_TYPE_PACKED_INT32_ARRAY(): return PackedInt32Array()
func make_TYPE_PACKED_INT64_ARRAY(): return PackedInt64Array()
func make_TYPE_PACKED_FLOAT32_ARRAY(): return PackedFloat32Array()
func make_TYPE_PACKED_FLOAT64_ARRAY(): return PackedFloat64Array()
func make_TYPE_PACKED_STRING_ARRAY(): return PackedStringArray()
func make_TYPE_PACKED_VECTOR2_ARRAY(): return PackedVector2Array()
func make_TYPE_PACKED_VECTOR3_ARRAY(): return PackedVector3Array()
func make_TYPE_PACKED_COLOR_ARRAY(): return PackedColorArray()
func make_TYPE_PACKED_VECTOR4_ARRAY(): 
	# Need to avoid explicit reference because this only exists in
	# Godot 4.3 onward
	var expression = Expression.new()
	expression.parse("PackedVector4Array()")
	return expression.execute()
