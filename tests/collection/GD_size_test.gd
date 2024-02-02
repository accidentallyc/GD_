extends SimpleTest

func it_should_get_size_of_collection():
	for key in Utils.collections:
		var collection = Utils.collections[key]
		
		expect(GD_.size(collection)).to.equal(4,"Should return correct size for %s" % key);

func it_should_return_0_for_falsey_objs():
	for falsey in Utils.falsey:
		expect(GD_.size(falsey)).to.equal(0,"Should return 0 for %s" % str(falsey));


class Class_With_Length:
	func length():
		return 200
		
func it_is_able_to_use_custom_length():
	var item = Class_With_Length.new()
	expect(GD_.size(item)).to.equal(200);

class Class_With_Size:
	func size():
		return 23
		
func it_is_able_to_use_custom_size():
	var item = Class_With_Size.new()
	expect(GD_.size(item)).to.equal(23);
