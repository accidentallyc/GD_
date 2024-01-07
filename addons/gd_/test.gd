var test = 300



## This method is like GD_.difference except that it accepts iteratee which 
## is invoked for each element of array and values to generate the criterion 
## by which they're compared using ==. The order and references of result 
## values are determined by the first array. The iteratee is 
## invoked with two arguments: (value, _UNUSED_)
## This attempts to replicate lodash's differenceBy.
## https://lodash.com/docs/4.17.15#differenceBy
##
## Arguments
##		array (Array): The array to inspect.
##		[values] (...Array): The values to exclude.
##		[iteratee=GD_.identity] (Function): The iteratee invoked per element.
## Returns
##		(Array): Returns the new array of filtered values.
## Example
## 		GD_.difference_by([2.1, 1.2], [2.3, 3.4], Math.floor)
## 		# => [1.2]
## 		 
## 		# The `GD_.property` iteratee shorthand.
## 		GD_.difference_by([{ 'x': 2 }, { 'x': 1 }], [{ 'x': 1 }], 'x')
## 		# => [{ 'x': 2 }]
static func difference_by(array_left, array_right, iteratee = GD_.identity): 
	if not(array_left is Array and array_right is Array):
		printerr("GD_.difference_by received a non-array type value")
		return null
		
	var iter_func = func (): return
	
	# new return array
	var new_array = []
	
	# store processed keyes here
	var keys_to_remove_map = {}
	for array_item_2 in array_right:
		keys_to_remove_map[iter_func.call(array_item_2)] = true
		
	var array_right_max = array_left.size()
	
	for left_item in array_left:
		var left_key = iter_func.call(left_item)
		if not(keys_to_remove_map.has(left_key)):
			new_array.append(left_item)
			
	return new_array
	
	
## This method is like GD_.difference except that it accepts comparator 
## which is invoked to compare elements of array to values. 
## The order and references of result values are determined by the first array. 
## The comparator is invoked with two arguments: (arrVal, othVal).
## This attempts to replicate lodash's differenceWith.
## https://lodash.com/docs/4.17.15#differenceWith
##
## Arguments
## 		array (Array): The array to inspect.
## 		[values] (...Array): The values to exclude.
## 		[comparator] (Function): The comparator invoked per element.
## Returns
## 		(Array): Returns the new array of filtered values.
## Example
## 		var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]
## 		 
## 		GD_.difference_with(objects, [{ 'x': 1, 'y': 2 }], GD_.is_equal)
## 		# => [{ 'x': 2, 'y': 1 }]
static func difference_with(array_left, array_right, comparator:Callable): 
	if not(array_left is Array and array_right is Array):
		printerr("GD_.difference_with received a non-array type value")
		return null
		
	var new_array = []
	var has_match = false
	for left_item in array_left:
		has_match = false
		for right_item in array_right:
			var res = comparator.call(left_item,right_item)
			if comparator.call(left_item,right_item):
				has_match = true
				break
		if not(has_match):
			new_array.append(left_item)
	return new_array
	
