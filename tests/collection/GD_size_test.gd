extends SimpleTest

func it_should_get_size_of_collection():
	for key in Utils.collections:
		var collection = Utils.collections[key]
		
		expect(GD_.size(collection)).to.equal(4,"Should return correct size for %s" % key)

func it_should_return_0_for_falsey_objs():
	for k in Utils.falsey:
		var falsey = Utils.falsey[k]
		expect(GD_.size(falsey)).to.equal(0,"Should return 0 for %s" % str(falsey))

class Class_With_Length:
	func length():
		return 200
		
func it_is_able_to_use_custom_length():
	var item = Class_With_Length.new()
	expect(GD_.size(item)).to.equal(200)

class Class_With_Size:
	func size():
		return 23
		
func it_is_able_to_use_custom_size():
	var item = Class_With_Size.new()
	expect(GD_.size(item)).to.equal(23)

func it_should_work_with_custom_iterators():
	var iterator = Utils.TestIterator.new(1,3,1)
	expect(GD_.size(iterator)).to.equal(2)
	expect(Utils.get_last_warning()).to.equal("GD_.size received a custom iterator that doesnt implement size or length. This will be expensive to calculate")
