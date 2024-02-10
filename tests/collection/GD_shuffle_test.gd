extends SimpleTest


func it_can_shuffle_any_collection():
	assert_was_shuffled([1,2,3,4], "Basic array")
	assert_was_shuffled("1234", "String")
	assert_was_shuffled(Utils.dict, "Dictionary")
	assert_was_shuffled(Utils.TestIterator.new(0,5,1), "Dictionary")


func assert_was_shuffled(collection,  title):
	var attempts =[
		# atleast 1 of them should be uniqueif it really shuffled right?
		GD_.shuffle(collection),
		GD_.shuffle(collection),
		GD_.shuffle(collection),
		GD_.shuffle(collection)
	]
	var iterable = GD_.keyed_iterable(attempts)
	
	for i1 in iterable:
		for i2 in iterable:
			if i1 == i2: continue # ignore self
			var a = attempts[i1]
			var b = attempts[i2]
			if a != b:
				return true
			
	expect_fail("%s - failed to shuffle" % title)
