extends SimpleTest

var __INTERNAL__ := GD_.__INTERNAL__

func test_keyed_iterable():
	var ary = [1,2,3]
	expect( GD_.keyed_iterable(ary)).equal([0,1,2])
	expect( GD_.keyed_iterable(ary, -1)).equal([2])
	expect( GD_.keyed_iterable(ary, -2)).equal([1,2])
	expect( GD_.keyed_iterable(ary, 1)).equal([1,2])
	expect( GD_.keyed_iterable(ary, 2)).equal([2])
	expect( GD_.keyed_iterable(ary, 99)).equal([])
	
	var obj = {"a":1,"b":2,"c":3}
	expect( GD_.keyed_iterable(obj)).equal(["a","b","c"])
	expect( GD_.keyed_iterable(obj, -1)).equal(["c"])
	expect( GD_.keyed_iterable(obj, -2)).equal(["b","c"])
	expect( GD_.keyed_iterable(obj, 1)).equal(["b","c"])
	expect( GD_.keyed_iterable(obj, 2)).equal(["c"])
	expect( GD_.keyed_iterable(obj, 99)).equal([])
	
	var str = "abc"
	expect( GD_.keyed_iterable(str)).equal([0,1,2])
	expect( GD_.keyed_iterable(ary, -1)).equal([2])
	expect( GD_.keyed_iterable(ary, -2)).equal([1,2])
	expect( GD_.keyed_iterable(str, 1)).equal([1,2])
	expect( GD_.keyed_iterable(str, 2)).equal([2])
	expect( GD_.keyed_iterable(str, 99)).equal([])
	
	expect(GD_.keyed_iterable(PackedByteArray([1,2,3,4]))).equal([0,1,2,3])
	expect(GD_.keyed_iterable(PackedInt32Array([1,2,3,4]))).equal([0,1,2,3])
	expect(GD_.keyed_iterable(PackedInt64Array([-2^63, 2^63 - 1]))).equal([0,1])
	expect(GD_.keyed_iterable(PackedFloat32Array([1.2,3.4]))).equal([0,1])
	expect(GD_.keyed_iterable(PackedFloat64Array([1.2,3.4]))).equal([0,1])
	expect(GD_.keyed_iterable(PackedStringArray(["1234"]))).equal([0])
	expect(GD_.keyed_iterable(PackedVector2Array([Vector2.ONE]))).equal([0])
	expect(GD_.keyed_iterable(PackedVector3Array([Vector3.ONE]))).equal([0])
	expect(GD_.keyed_iterable(PackedColorArray([Color.AQUA]))).equal([0])

func test_string_to_path_should_give_path():
	expect( __INTERNAL__.string_to_path("a/b") ).equal(["a","b"], "Failed at basic split")
	expect( __INTERNAL__.string_to_path("a[0]") ).equal(["a",0], "Int strings should be parsed as integer")
	expect( __INTERNAL__.string_to_path("a[0.25]") ).equal(["a",0.25], "Float strings should be parsed as float")
	expect( __INTERNAL__.string_to_path("a['0']") ).equal(["a","0"], "Failed at splitting into string-integer index (single quote)")
	expect( __INTERNAL__.string_to_path("a[\"0\"]") ).equal(["a","0"], "Failed at splitting into string-integer index (double quote)")
	expect( __INTERNAL__.string_to_path("a[]") ).equal(["a",&""], "Failed at splitting into empty back")
	expect( __INTERNAL__.string_to_path("a[\'\']") ).equal(["a",""], "Failed at splitting into empty string (single quote)")
	expect( __INTERNAL__.string_to_path("a[\"\"]") ).equal(["a",""], "Failed at splitting into empty string (double quote)")
	expect( __INTERNAL__.string_to_path("a/b/c") ).equal(["a","b","c"], "Failed at multi split")

func test_validate_callable():
	# Don't execute test on older versions
	if not __INTERNAL__.is_version(">=4.3"):
		return
	
	var tmp = func (b): return 2
	expect(__INTERNAL__.validate_callable(tmp, 5,5))\
		.equal("Callable needs to have exactly 5 args but found 1")
	expect(__INTERNAL__.validate_callable(tmp, 2,3))\
		.equal("Callable needs to have between 2-3 args but found 1")
	
	tmp = func (a,b,c,d,e): return 2
	expect(__INTERNAL__.validate_callable(tmp, 5,5)).equal(null)

	tmp = func (a,b): return 2
	expect(__INTERNAL__.validate_callable(tmp, 2,3)).equal(null)
	
	tmp = func (a): return 2
	__INTERNAL__.callf(tmp, [1,2,3,4,5]) 	# no error
	__INTERNAL__.callf(tmp) 				# no error
