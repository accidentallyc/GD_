extends SimpleTest


func it_should_return_true_if_predicate_returns_truthy_for_all_elements():
	expect(GD_.every([true, 1, 'a'], GD_.identity)).to.equal(true)


func it_should_return_true_for_empty_collections():
	for collection in Utils.empties:
		expect(GD_.every(collection, GD_.identity)).to.equal(true)
#

func it_should_return_false_as_soon_as_predicate_returns_falsey():
	var ref = {"count":0}
	
	var callback = func (a,b):
		ref.count += 1
		return a
	
	expect(GD_.every([true,false,true], callback)).to.equal(false)
	expect(ref.count).to.equal(2)


func it_should_use_identity_when_predicate_is_nullish():
	expect(GD_.every([true, 1, 'a'])).to.equal(true)


func it_should_work_with_property_shorthands():
	var objects = [
		{ "a": 0, "b": 1 },
		{ "a": 1, "b": 2 },
	];
	expect(GD_.every(objects, 'a')).to.equal(false);
	expect(GD_.every(objects, 'b')).to.equal(true);


func it_should_work_with_matches_shorthands():
	var objects = [
		{ "a": 0, "b": 0 },
		{ "a": 0, "b": 1 },
	];
	expect(GD_.every(objects, { "a": 0 })).to.equal(true);
	expect(GD_.every(objects, { "b": 1 })).to.equal(false);


func it_should_work_as_an_iteratee_for_methods_like_map():
	var actual = GD_.map([[1]], GD_.every);
	expect(actual).equal([true]);
