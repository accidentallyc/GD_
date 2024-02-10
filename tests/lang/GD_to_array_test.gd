extends SimpleTest

func it_converts_arrayable_types_to_array():
	var packed_array = PackedFloat32Array([1,2,3,4])
	var cases = {
		[1,2,3,4] : [1,2,3,4],
		"1234":["1","2","3","4"],
		{
			"dict_key_1":1,
			"dict_key_2":2,
			"dict_key_3":3,
			"dict_key_4":4
		}: [1,2,3,4],
		packed_array: [1,2,3,4]
	}

	for input in GD_.keyed_iterable(cases):
		var result = GD_.to_array(input)
		var expected = cases[input]
		expect(str(result)).to.equal(str(expected), 
		"Failed to convert %s(%s) into an array" % [str(input),type_string(typeof(input))])
		
func it_returns_empty_array_for_invalid_types():
	var invalid_types = [
		null,
		1,
		{},
		Utils.dict
	]
	
	for input in GD_.keyed_iterable(invalid_types):
		expect(GD_.to_array(input)).to.have.size(0)
