extends SimpleTest


func it_should_work_with_all_empties():
    var empties = {
        "array": [],
        "dict": {},
        "string": "",
        "string name": &"",
        "packed array": PackedByteArray([]),
        "empty iterator": Utils.TestIterator.new(0,0,0),
        "node with size(0)": Utils.TestNodeSized.new(0),
        "node with size(-1)": Utils.TestNodeSized.new(-1),
        "invalid obj": GD_.identity,
        "null":null
    }
    for key in empties:
        var empty_thing = empties[key]
        expect(GD_.is_empty(empty_thing)).to.be.truthy("Failed at %s"%key)

func it_should_return_false_for_non_empties():
    var non_empties = {
        "array": [1],
        "dict": {1:2},
        "string": "foobar",
        "string name": &"foobar",
        "packed array": PackedByteArray([1]),
        "empty iterator": Utils.TestIterator.new(0,1,3),
        "node with size": Utils.TestNodeSized.new(25)
    }
    for key in non_empties:
        var thing = non_empties[key]
        expect(GD_.is_empty(thing)).to.be.falsey("Failed at %s"%key)
