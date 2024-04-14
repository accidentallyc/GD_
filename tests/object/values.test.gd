extends SimpleTest

# Called when the node enters the scene tree for the first time.
func it_should_just_return_arrays():
    expect(GD_.values([1,2,3,4])).to.equal([1,2,3,4])

func it_should_split_strings():
    expect(GD_.values("1234")).to.equal(["1","2","3","4"])
    
func it_should_return_dict_values():
    var dict = {"a":1,"b":2,"c":3,"d":4}
    expect(GD_.values(dict)).to.equal([1,2,3,4])

func it_should_return_empty_array_for_anything_else():
    var node = Sprite2D.new()
    expect(GD_.values(node)).to.equal([])
    node.queue_free()
    
