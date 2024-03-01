extends SimpleTest

func it_should_work_with_a_comparator():
    var objects = [
        { "x": 1, "y": 2 },
        { "x": 2, "y": 1 },
    ]
    var others = [
        { "x": 1, "y": 1 },
        { "x": 1, "y": 2 },
    ]
    var actual = GD_.union_with(objects, others, GD_.is_equal)
    expect(actual).equal([objects[0], objects[1], others[0]])

func it_should_output_values_from_the_first_possible_array():
    var objects = [{ "x": 1, "y": 1 }]
    var others = [{ "x": 1, "y": 2 }]

    var actual =  GD_.union_with(objects, others, func (a, b): return a.x == b.x)
    expect(actual).equal([{ "x": 1, "y": 1 }])
