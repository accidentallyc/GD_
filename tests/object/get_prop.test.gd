## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_should_get_string_keyed_property_values( ):
    var object = { "a": 1, "b":[1], "c": {0:1}, '':1}
    
    for path in [
            'a',	# regular get
            ['a'],	# array path get
            "b:0",	# get using : notation but target is array
            "b[0]",	# get using [] notation but target is array
            "c:0",	# get using : notation but target is object
            "c[0]",	# get using [] notation but target is object
            "",		# empty string should work as key
        ]:
        expect(GD_.get_prop(object, path)).to.equal(1, &"Failed to find path using %s " % path)
        
        
func it_should_fetch_string_and_number_separately():
    """
    This test differs from lodash because of how dictionaries behave.
    In javascript {"0":"hello",0:"world"} resolves as {0:"world"}
    While in gdscript it resolves as {"0":"hello",0:"world"}.
    
    See GD_.get_prop JS comparison for more details
    """
    const object = { '-0': 'a', 0: 'b' ,"0":'c'}
    
    var result = []
    for path in ["-0",-0, 0, "0"]:
        result.append(GD_.get_prop(object, path))
    
    expect(result).to.equal(["a","b","b","c"])
    
    
func it_should_get_deep_property_values():
    var object = { 'a': { 'b': 2 } }
    
    for path in ['a:b',['a','b']]:
        expect(GD_.get_prop(object,path)).to.equal(2)
    
    
func it_should_get_a_key_over_a_path():
    var object = { 'a.b': 1, 'a': { 'b': 2 } }
    
    for path in ['a:b',['a','b']]:
        expect(GD_.get_prop(object,path)).to.equal(2)
    
    
func it_should_not_coerce_array_paths_to_strings():
    var object = { "a:b:c": 3, "a": { "b": { "c": 4 } } }
    expect(GD_.get_prop(object, ['a', 'b', 'c'])).equal(4)
    
    
func it_should_not_ignore_empty_brackets():
    const object = { 'a': { '': 1 } }
    expect(GD_.get_prop(object, 'a[]')).equal(1)
            

func it_should_return_null_when_object_is_nullish():
    for target in [null,0,false]:
        expect(GD_.get_prop(target, '')).equal(null)
    

func it_should_return_undefined_if_parts_of_path_are_missing():
    var object = { "a": [null] }
    
    for path in ['a[1].b.c', ['a', '1', 'b', 'c']]:
        expect(GD_.get_prop(object, path)).equal(null)
    
func it_should_be_able_to_return_null_values_even_default():
    var object = { "a": { "b": null } };

    for path in [ 'a:b',['a', 'b']]:
        expect(GD_.get_prop(object, path, "NOT THIS")).equal(null, str("Returned default instead of null on path ",path))
            

func it_should_return_the_default_value_for_undefined_values():
    
    expect(GD_.get_prop({},'foo', "DEFAULT_VAL")).to.equal("DEFAULT_VAL", "Failed default value when accessing objects")
    expect(GD_.get_prop([],'foo', "DEFAULT_VAL")).to.equal("DEFAULT_VAL", "Failed default value when accessing arrays")
    expect(GD_.get_prop("",'foo', "DEFAULT_VAL")).to.equal("DEFAULT_VAL", "Failed default value when accessing strings")
    expect(GD_.get_prop(1,'foo', "DEFAULT_VAL")).to.equal("DEFAULT_VAL", "Failed default value when accessing ints")
    expect(GD_.get_prop(Vector2(),'foo', "DEFAULT_VAL")).to.equal("DEFAULT_VAL", "Failed default value when accessing non-objects")
    
    var node = Node.new()
    expect(GD_.get_prop(node,'foo', "DEFAULT_VAL")).to.equal("DEFAULT_VAL", "Failed default value when accessing Nodes")
    node.free()
    
func it_should_return_the_default_value_when_path_is_empty():
    expect(GD_.get_prop({}, [], 'a')).equal('a');


func it_can_access_instances_of_none_gd_object():
    var vector = Vector2(2,5)
    var result = GD_.get_prop(vector, "x")
    expect(result).to.equal(2)

func it_can_get_single_prop_from_dictionary():
    var dict = {"foo":"bar"}
    var result = GD_.get_prop(dict,"foo")
    expect(result).to.equal("bar")


func it_can_get_single_prop_from_object():
    var node = Node2D.new()
    node.global_position = Vector2(15,10)
    
    var result = GD_.get_prop(node,"global_position")
    expect(result).to.equal(Vector2(15,10))
    node.free()
    
    
func it_can_get_single_prop_from_an_array():
    var array = ["never","gonna","give","you","up"]
    
    for path in ["3","[3]"]:
        expect(GD_.get_prop(array,path)).to.equal("you", "Failed to get path using %s"%path)
    
    
func it_can_get_nested_properties():
    var node = Node2D.new()
    node.global_position = Vector2(999,123)
    
    var everything_everywhere_all_at_once = {
        "array": ["hello", node, "world"]
    }

    var path = "array:1:global_position:y"
    var result = GD_.get_prop(everything_everywhere_all_at_once,path)
    expect(result).equal(123)
    
func it_can_access_by_array():
    var node = Node2D.new()
    node.global_position = Vector2(999,123)
    
    var everything_everywhere_all_at_once = {
        "array": ["hello", node, "world"]
    }

    var path = ["array",1,"global_position","y"]
    var result = GD_.get_prop(everything_everywhere_all_at_once,path)
    expect(result).equal(123)


func it_returns_null_in_invalid_cases():
    var vector = Vector2(2,5)
    
    expect(GD_.get_prop(vector, vector)).to.equal(null)
    expect(GD_.get_prop(vector, null)).to.equal(null)
    expect(GD_.get_prop(vector, {})).to.equal(null)
    expect(GD_.get_prop(vector, "baz")).to.equal(null)


func it_returns_default_if_provided():
    var vector = Vector2(2,5)
    
    expect(GD_.get_prop(vector, vector, "foobar")).to.equal("foobar")
    expect(GD_.get_prop(vector, null, "foobar")).to.equal("foobar")
    expect(GD_.get_prop(vector, {}, "foobar")).to.equal("foobar")
    expect(GD_.get_prop(vector, "baz", "foobar")).to.equal("foobar")
