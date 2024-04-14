extends SimpleTest

var inputs = {
    "Basic array": [1,2,3,4],
    "String": "1234",
    "Dictionary": Utils.dict,
    "Iterator": Utils.TestIterator.new(0,5,1)
}

func it_can_shuffle_any_collection():
    assert_was_shuffled([1,2,3,4], "Basic array")
    assert_was_shuffled("1234", "String")
    assert_was_shuffled(Utils.dict, "Dictionary")
    assert_was_shuffled(Utils.TestIterator.new(0,5,1), "Dictionary")
    
#func it_can_be_used_in_map():
    #var shuffled_inputs = GD_.map(inputs)
    #for key in inputs:
        #assert_was_shuffled(inputs[key], key)


func assert_was_shuffled(collection,  title):
    var attempts =[
        # atleast 1 of them should be uniqueif it really shuffled right?
        GD_.shuffle(collection),
        GD_.shuffle(collection),
        GD_.shuffle(collection),
        GD_.shuffle(collection)
    ]
    var iterable = GD_.keyed_iterable(attempts)
    var actual_vals = GD_.values(collection)
    actual_vals.sort()

    for i1 in iterable:
        for i2 in iterable:
            if i1 == i2: continue # ignore self
            var a = attempts[i1]
            var b = attempts[i2]
            if a != b:
                var vals_a = GD_.values(a)
                vals_a.sort()
                
                var vals_b = GD_.values(b)
                vals_b.sort()
                
                if GD_.is_equal(vals_a,actual_vals) and GD_.is_equal(vals_b,actual_vals):
                    return true
                expect_fail("%s - Found a match but values are unexpected" % title)
    expect_fail("%s - failed to shuffle" % title)
