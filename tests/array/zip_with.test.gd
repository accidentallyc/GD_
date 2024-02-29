extends SimpleTest


func it_should_work_with_odd_number_of_args():
    var array1 = [1]
    var array2 = [10, 'a']
    var array3 = [100, 'b', {"foo":"bar"}]
    
    var iteratee = func(a,b,c): return [a,b,c]
    var actual = GD_.zip_with(array1,array2,array3, iteratee)
    expect(actual[0]).equal([1,10,100])
    expect(actual[1]).equal([null,'a','b'])
    expect(actual[2]).equal([null,null,{"foo":"bar"}])
    

func it_should_default_to_just_return_all_elements_of_same_index_if_no_callable():
    var array1 = [1, 2]
    var array2 = [10, 20]
    var array3 = [100, 200]
    
    var actual = GD_.zip_with(array1,array2,array3)
    expect(actual[0]).equal([1,10,100])
    expect(actual[1]).equal([2,20,200])
    

func it_should_zip_arrays_combining_grouped_elements_with_iteratee():
    var array1 = [1, 2]
    var array2 = [10, 20]
    var array3 = [100, 200]
    
    var iteratee = func(a,b,c): return a + b + c
    var actual = GD_.zip_with(array1,array2,array3, iteratee)
    expect(actual).equal([111, 222])
