extends SimpleTest

var ary = ["a","b","c"]
func it_returns_first_accum_value_if_using_identity():
	expect(GD_.reduce_right(ary)).to.equal("c")
	expect(GD_.reduce_right(ary, GD_.identity, 200)).to.equal(200)


func it_should_accumulate_using_a_custom_callable():
	var cb = func (accum, kv): return accum + kv.value
	
	expect(GD_.reduce_right(ary, cb)).to.equal("cba")


func it_should_provide_key_and_value_as_second_args():
	var stuff = []
	var cb = func (accum, kv): 
		stuff.append(accum)
		stuff.append(kv)
		
	GD_.reduce_right(["a","b"],cb)
	
	expect(stuff).to.equal(["b",{"key":0,"value":"a"}])


func it_returns_null_for_none_collection():
	expect(GD_.reduce_right(Vector2.ONE)).to.equal(null)
