extends SimpleTest

func it_returns_true_for_arrays_and_every_packed_array():
    var values = {
        "Array":[1,2,3,4],
        "PackedByteArray": PackedByteArray([1,2,3,4]),
        "PackedInt32Array": PackedInt32Array([1,2,3,4]),
        "PackedInt64Array": PackedInt64Array([-2^63, 2^63 - 1]),
        "PackedFloat32Array": PackedFloat32Array([1.2,3.4]),
        "PackedFloat64Array": PackedFloat64Array([1.2,3.4]),
        "PackedStringArray": PackedStringArray(["1234"]),
        "PackedVector2Array": PackedVector2Array([Vector2.ONE]),
        "PackedVector3Array": PackedVector3Array([Vector3.ONE]),
        "PackedColorArray": PackedColorArray([Color.AQUA]),
    }
    
    for k in values:
        expect(GD_.is_array(values[k])).to.be.truthy("Should be truthy at %s" % k)

func it_returns_false_for_everything_else():
    var values = {
        "Dictionary": {1:2,3:4},
        "String":"1234",
        "StringName": &"1234",
        "null": null,
        "Custom Iterator": Utils.TestIterator.new(1,10,2)
    }
    
    for k in values:
        expect(GD_.is_array(values[k])).to.be.falsey("Should be falsey at %s" % k)		
