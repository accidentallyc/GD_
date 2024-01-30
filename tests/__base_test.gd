extends SimpleTest

var __INTERNAL__ := GD_.__INTERNAL__

func test_string_to_path_should_give_path():
	expect( __INTERNAL__.string_to_path("a:b") ).equal(["a","b"], "Failed at basic split")
	expect( __INTERNAL__.string_to_path("a[0]") ).equal(["a",0], "Int strings should be parsed as integer")
	expect( __INTERNAL__.string_to_path("a[0.25]") ).equal(["a",0.25], "Float strings should be parsed as float")
	expect( __INTERNAL__.string_to_path("a['0']") ).equal(["a","0"], "Failed at splitting into string-integer index (single quote)")
	expect( __INTERNAL__.string_to_path("a[\"0\"]") ).equal(["a","0"], "Failed at splitting into string-integer index (double quote)")
	expect( __INTERNAL__.string_to_path("a[]") ).equal(["a",&""], "Failed at splitting into empty back")
	expect( __INTERNAL__.string_to_path("a[\'\']") ).equal(["a",""], "Failed at splitting into empty string (single quote)")
	expect( __INTERNAL__.string_to_path("a[\"\"]") ).equal(["a",""], "Failed at splitting into empty string (double quote)")
	expect( __INTERNAL__.string_to_path("a:b:c") ).equal(["a","b","c"], "Failed at multi split")
