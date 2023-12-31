extends SimpleTest

var array = ['a','b','c','d']

func it_chunks_arrays_with_default_size_1():
	expect(GD_.chunk(array)).equal([['a'],['b'],['c'],['d']])


func it_chunks_arrays_with_specific_size():
	expect(GD_.chunk(array,2)).equal([['a','b'],['c','d']])
	expect(GD_.chunk(array,3)).equal([['a','b','c',],['d']])
	
	
func it_chunks_arrays_with_size_bigger_than_array():
	expect(GD_.chunk(array,10)).equal([['a','b','c','d']])
