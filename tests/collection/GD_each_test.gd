## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_should_iterate_over_array_and_execute_function():
	var array = [1, 50]
	var array_expected = []
	var callback = func (v,i):
		array_expected.append(str(i,":",v))
	GD_.each(array,callback)
	expect(array_expected).to.equal(["0:1","1:50"])

func it_should_iterate_over_dictionary_and_execute_function():
	var dictionary = { 'a': 1, 'b': 2 }
	var dictionary_expected = {}
	var callback = func (v,i):
		dictionary_expected[str(i,":",v)] = true
	GD_.each(dictionary,callback)
	expect(dictionary_expected).to.equal({
		"a:1":true,
		"b:2":true
	})

func it_should_iterate_short_circuits_if_false_returned():
	var array = [96, 50,300]
	var array_expected = []
	var callback = func (v,i):
		array_expected.append(str(i,":",v))
		return false
	GD_.each(array,callback)
	expect(array_expected).to.equal(["0:96"])
