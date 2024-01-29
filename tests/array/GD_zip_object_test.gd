extends SimpleTest


func it_should_zip_2_arrays_into_object():
	var keys = ["name","age"]
	var vals = ["Alfred",12]
	
	var result = GD_.zip_object(keys,vals)
	expect(result).equal({"name":"Alfred","age":12})


func it_should_only_zip_based_on_keys():
	var keys = ["name","age"]
	var vals = ["Alfred",12, "foobar"]
	
	var result = GD_.zip_object(keys,vals)
	expect(result).equal({"name":"Alfred","age":12})


func it_should_default_to_null_if_second_array_is_less_than_first():
	var keys = ["name","age","occupation"]
	var vals = ["Alfred",12]
	
	var result = GD_.zip_object(keys,vals)
	expect(result).equal({"name":"Alfred","age":12,"occupation":null})
