## @TODO Reuse tests from lodash repo
extends SimpleTest

func it_can_return_slice_from_start_to_end():
    var array = [0,1,2,3,4]
    expect(GD_.slice(array,1,4)).to.equal([1,2,3])


func it_can_return_all_values_if_no_args_provided():
    var array = [0,1,2,3,4]
    expect(GD_.slice(array)).to.equal([0,1,2,3,4])


func it_treats_negative_starts_and_end_as_relative_from_end():
    var array = [0,1,2,3,4]
    expect(GD_.slice(array,-4,-1)).to.equal([1,2,3])
