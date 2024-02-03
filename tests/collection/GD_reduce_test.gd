extends SimpleTest

var ary = ["a","b","c"]

func it_returns_first_accum_value_if_using_identity():
	expect(GD_.reduce(ary)).to.equal("a")
	expect(GD_.reduce(ary, GD_.identity, 200)).to.equal(200)


func it_should_accumulate_using_a_custom_callable():
	var cb = func (accum, kv): return accum + kv.value
	
	expect(GD_.reduce(ary, cb)).to.equal("abc")


func it_should_provide_key_and_value_as_second_args():
	var stuff = []
	var cb = func (accum, kv): 
		stuff.append(accum)
		stuff.append(kv)
		
	GD_.reduce(["a","b"],cb)
	
	expect(stuff).to.equal(["a",{"key":1,"value":"b"}])


func it_returns_null_for_none_collection():
	expect(GD_.reduce(Vector2.ONE)).to.equal(null)
