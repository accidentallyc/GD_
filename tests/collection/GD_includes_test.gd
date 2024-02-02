extends SimpleTest

func _before_each():
	Utils.reset_warning()

func it_should_work_with_different_collection_types():
	for key in Utils.collections:
		var collection = Utils.collections[key]
		expect(GD_.includes(collection, "c")).to.be.truthy("Should work with %s and  return `true` for  matched values" % key);
	
func it_should_differentiate_strings_and_integer_strings():
	expect(GD_.includes([1,2], "2")).to.be.falsey("Found str(2) in an array of ints");
	expect(GD_.includes([1,2], 2)).to.be.truthy("Failed to find int(2) an array of ints");
	expect(GD_.includes(["1","2"], 2)).to.be.falsey("Found str(2) in an array of ints");
	expect(GD_.includes(["1","2"], "2")).to.be.truthy("Failed to find str(2) an array of strings");
	
	var warning = Utils.get_last_warning()
	expect(warning).equal(null, "Should be no warnings")


func it_should_return_false_for_none_collections_along_with_error():
	expect(GD_.includes(Vector2.ONE,"x")).to.be.falsey()
	expect(Utils.get_last_warning()).equal("GD_.includes received a non-collection type value")


func it_should_respect_from_index():
	expect(GD_.includes([1, 2, 3], 2,0)).truthy("Should find item because index starts from zero")
	expect(GD_.includes([1, 2, 3], 2,1)).truthy("Should find item since index == item index")
	expect(GD_.includes([1, 2, 3], 2,2)).falsey("Should fail because index > item index")
	expect(GD_.includes([1, 2, 3], 2,999)).falsey("Should fail with invalid index")
	expect(GD_.includes([1, 2, 3], 2,-1)).falsey("Should fail because -1 starts at the third index")
	expect(GD_.includes([1, 2, 3], 2,-2)).truthy("Should find item since -2 is at the item index")
