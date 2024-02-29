extends SimpleTest


func it_should_default_to_just_return_all_elements_of_same_index_if_no_callable():
    var array1 = [1, 2]
    var array2 = [10, 20]
    var array3 = [100, 200]
    
    var actual = GD_.zip(array1,array2,array3)
    expect(actual[0]).equal([1,10,100])
    expect(actual[1]).equal([2,20,200])
