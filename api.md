## `chunk `
 Creates an array of elements split into groups the length of size. 
 If array can't be split evenly, the final chunk will be the remaining elements.
 This attempts to replicate lodash's chunk. 
 https://lodash.com/docs/4.17.15#chunk

### Arguments
 *  array (Array): The array to process.
 *  [size=1] (number): The length of each chunk
### Example
```gdscript
 GD_.chunk(['a', 'b', 'c', 'd'], 2)
 # => [['a', 'b'], ['c', 'd']]
  
 GD_.chunk(['a', 'b', 'c', 'd'], 3)
 # => [['a', 'b', 'c'], ['d']]
```


## `compact `
 Creates an array with all falsey values removed. 
 The falsiness is determined by a basic if statement.
 The values false, null, 0, "", [], and {} are falsey.
 This attempts to replicate lodash's compact. 
 https://lodash.com/docs/4.17.15#compact

### Arguments
 *  array (Array): The array to process.
 *  [size=1] (number): The length of each chunk
### Example
```gdscript
 GD_.compact([0, 1, false, 2, '', 3])
 # => [1, 2, 3]
```


## `concat `
 Creates a new array concatenating array with any additional arrays and/or values.
 This attempts to replicate lodash's concat. 
 This func can receive up to 10 concat values. Hopefully thats enough
 This attempts to replicate lodash's concat.
 https://lodash.com/docs/4.17.15#concat

### Arguments
 *  array (Array): The array to concatenate.
 *  [values] (...*): The values to concatenate.
### Example
```gdscript
 var array = [1]
 var other = GD_.concat(array, 2, [3], [[4]])
  
 print(other)
 # => [1, 2, 3, [4]]
  
 print(array)
 # => [1]
```


## `difference `
 Creates an array of array values not included in the other given arrays 
 using == for comparisons. The order and references of result values 
 are determined by the first array.
 This attempts to replicate lodash's difference.
 https://lodash.com/docs/4.17.15#difference

### Arguments
 * 	array (Array): The array to inspect.
 * 	[values] (...Array): The values to exclude.
### Example
```gdscript
	GD_.difference([2, 1], [2, 3])
	# => [1]
```


## `difference_by `
 This method is like GD_.difference except that it accepts iteratee which 
 is invoked for each element of array and values to generate the criterion 
 by which they're compared using ==. The order and references of result 
 values are determined by the first array. The iteratee is 
 invoked with two arguments: (value, _UNUSED_)
 This attempts to replicate lodash's differenceBy.
 https://lodash.com/docs/4.17.15#differenceBy

### Arguments
 * array (Array): The array to inspect.
 * [values] (...Array): The values to exclude.
 * [iteratee=GD_.identity] (Function): The iteratee invoked per element.
### Example
```gdscript
 GD_.difference_by([2.1, 1.2], [2.3, 3.4], Math.floor)
 # => [1.2]
  
 # The `GD_.property` iteratee shorthand.
 GD_.difference_by([{ 'x': 2 }, { 'x': 1 }], [{ 'x': 1 }], 'x')
 # => [{ 'x': 2 }]
```


## `difference_with `
 This method is like GD_.difference except that it accepts comparator 
 which is invoked to compare elements of array to values. 
 The order and references of result values are determined by the first array. 
 The comparator is invoked with two arguments: (arrVal, othVal).
 This attempts to replicate lodash's differenceWith.
 https://lodash.com/docs/4.17.15#differenceWith

### Arguments
 *  array (Array): The array to inspect.
 *  [values] (...Array): The values to exclude.
 *  [comparator] (Function): The comparator invoked per element.
### Example
```gdscript
 var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]
  
 GD_.difference_with(objects, [{ 'x': 1, 'y': 2 }], GD_.is_equal)
 # => [{ 'x': 2, 'y': 1 }]
```


## `drop `
 Creates a slice of array with n elements dropped from the beginning.
 This attempts to replicate lodash's drop.
 https://lodash.com/docs/4.17.15#drop

### Arguments
 *  array (Array): The array to query.
 *  [n=1] (number): The number of elements to drop.
### Example
```gdscript
 GD_.drop([1, 2, 3])
 # => [2, 3]
  
 GD_.drop([1, 2, 3], 2)
 # => [3]
  
 GD_.drop([1, 2, 3], 5)
 # => []
  
 GD_.drop([1, 2, 3], 0)
 # => [1, 2, 3]
```


## `drop_right `
 Creates a slice of array with n elements dropped from the beginning.
 This attempts to replicate lodash's dropRight.
 https://lodash.com/docs/4.17.15#dropRight
 
### Arguments
 *  array (Array): The array to query.
 *  [n=1] (number): The number of elements to drop.
### Example
```gdscript
 GD_.drop_right([1, 2, 3])
 # => [1, 2]
 
 GD_.drop_right([1, 2, 3], 2)
 # => [1]
  
 GD_.drop_right([1, 2, 3], 5)
 # => []
  
 GD_.drop_right([1, 2, 3], 0)
 # => [1, 2, 3]
```


## `drop_right_while `
 Creates a slice of array excluding elements dropped from the end. 
 Elements are dropped until predicate returns falsey. 
 The predicate is invoked with two arguments: (value, index).
 This attempts to replicate lodash's dropRightWhile.
 https://lodash.com/docs/4.17.15#dropRightWhile

### Arguments
 *  array (Array): The array to query.
 *  [predicate=GD_.identity] (Function): The function invoked per iteration.
### Example
```gdscript
 var users = [
   { 'user': 'barney',  'active': true },
   { 'user': 'fred',    'active': false },
   { 'user': 'pebbles', 'active': false }
 ]
  
 GD_.drop_right_while(users, func (o,_unused): return !o.active)
 # => objects for ['barney']
  
 # The `GD_.matches` iteratee shorthand.
 GD_.drop_right_while(users, { 'user': 'pebbles', 'active': false })
 # => objects for ['barney', 'fred']
  
 # The `GD_.matches_property` iteratee shorthand.
 GD_.drop_right_while(users, ['active', false])
 # => objects for ['barney']
  
 # The `GD_.property` iteratee shorthand.
 GD_.drop_right_while(users, 'active')
 # => objects for ['barney', 'fred', 'pebbles']
```


## `drop_while `
 Creates a slice of array excluding elements dropped from the beginning. 
 Elements are dropped until predicate returns falsey. 
 The predicate is invoked with two arguments: (value, index).
 This attempts to replicate lodash's dropWhile.
 https://lodash.com/docs/4.17.15#dropWhile

### Arguments
 *  array (Array): The array to query.
 *  [predicate=GD_.identity] (Function): The function invoked per iteration.
### Example
```gdscript
 var users = [
   { 'user': 'barney',  'active': false },
   { 'user': 'fred',    'active': false },
   { 'user': 'pebbles', 'active': true }
 ]
  
 GD_.drop_while(users, func (o, _unused): return !o.active )
 # => objects for ['pebbles']
  
 # The `GD_.matches` iteratee shorthand.
 GD_.drop_while(users, { 'user': 'barney', 'active': false })
 # => objects for ['fred', 'pebbles']
  
 # The `GD_.matches_property` iteratee shorthand.
 GD_.drop_while(users, ['active', false])
 # => objects for ['pebbles']
  
 # The `GD_.property` iteratee shorthand.
 GD_.drop_while(users, 'active')
 # => objects for ['barney', 'fred', 'pebbles']
```


## `fill `
 Fills elements of array with value from start up to, but not including, end.
 Note: This method mutates array.
 This attempts to replicate lodash's fill.
 https://lodash.com/docs/4.17.15#fill

### Arguments
 *  array (Array): The array to fill.
 *  value (*): The value to fill array with.
 *  [start=0] (number): The start position.
 *  [end=array.length] (number): The end position.
### Example
```gdscript
 var array = [1, 2, 3]
  
 GD_.fill(array, 'a')
 print(array)
 # => ['a', 'a', 'a']
  
 GD_.fill(Array(3), 2)
 # => [2, 2, 2]
  
 GD_.fill([4, 6, 8, 10], '*', 1, 3)
 # => [4, '*', '*', 10]
```


## `find_index `
 This method is like GD_.find except that it returns the index of the first 
 element predicate returns truthy for instead of the element itself.
 This attempts to replicate lodash's find_index.
 https://lodash.com/docs/4.17.15#find_index

### Arguments
 *  array (Array): The array to inspect.
 *  [predicate=GD_.identity] (Function): The function invoked per iteration.
 *  [fromIndex=0] (number): The index to search from.
### Example
```gdscript
 var users = [
   { 'user': 'barney',  'active': false },
   { 'user': 'fred',    'active': false },
   { 'user': 'pebbles', 'active': true }
 ]
  
 GD_.find_index(users, func (o, _i): return o.user == 'barney' )
 # => 0
  
 # The `GD_.matches` iteratee shorthand.
 GD_.find_index(users, { 'user': 'fred', 'active': false })
 # => 1
  
 # The `GD_.matches_property` iteratee shorthand.
 GD_.find_index(users, ['active', false])
 # => 0
  
 # The `GD_.property` iteratee shorthand.
 GD_.find_index(users, 'active')
 # => 2
```


## `find_last_index `
 This method is like GD_.findIndex except that it iterates over 
 elements of collection from right to left.
 This attempts to replicate lodash's find_last_index.
 https://lodash.com/docs/4.17.15#find_last_index

### Arguments
 *  array (Array): The array to inspect.
 *  [predicate=GD_.identity] (Function): The function invoked per iteration.
 *  [fromIndex=array.length-1] (number): The index to search from.
### Example
```gdscript
 var users = [
   { 'user': 'barney',  'active': true },
   { 'user': 'fred',    'active': false },
   { 'user': 'pebbles', 'active': false }
 ]
  
 GD_.find_last_index(users, func(o,_index): return o.user == 'pebbles')
 # => 2
  
 # The `GD_.matches` iteratee shorthand.
 GD_.find_last_index(users, { 'user': 'barney', 'active': true })
 # => 0
  
 # The `GD_.matches_property` iteratee shorthand.
 GD_.find_last_index(users, ['active', false])
 # => 2
  
 # The `GD_.property` iteratee shorthand.
 GD_.find_last_index(users, 'active')
 # => 0
```


## `first `
 Alias to head
 This attempts to replicate lodash's first.
 https://lodash.com/docs/4.17.15#first


## `flatten `
 Flattens array a single level deep.
 This attempts to replicate lodash's flatten.
 https://lodash.com/docs/4.17.15#flatten

### Arguments
 *  array (Array): The array to flatten.
### Example
```gdscript
 GD_.flatten([1, [2, [3, [4]], 5]])
 # => [1, 2, [3, [4]], 5]
```


## `flatten_deep `
 Recursively flattens array.
 This attempts to replicate lodash's flattenDeep.
 https://lodash.com/docs/4.17.15#flattenDeep

### Arguments
 *  array (Array): The array to flatten.
### Example
```gdscript
GD_.flatten_deep([1, [2, [3, [4]], 5]])
# => [1, 2, 3, 4, 5]
```


## `flatten_depth `
 Recursively flatten array up to depth times.
 This attempts to replicate lodash's flattenDepth.
 https://lodash.com/docs/4.17.15#flattenDepth

### Arguments
 *  array (Array): The array to flatten.
 *  [depth=1] (number): The maximum recursion depth.
### Example
```gdscript
 var array = [1, [2, [3, [4]], 5]]
  
 GD_.flatten_depth(array, 1)
 # => [1, 2, [3, [4]], 5]
  
 GD_.flatten_depth(array, 2)
 # => [1, 2, 3, [4], 5]
```


## `from_pairs `
 The inverse of GD_.to_pairs.
 This method returns an object composed from key-value pairs.
 This attempts to replicate lodash's from_pairs.
 https://lodash.com/docs/4.17.15#from_pairs

### Arguments
 *  pairs (Array): The key-value pairs.
### Example
```gdscript
GD_.from_pairs([['a', 1], ['b', 2]])
# => { 'a': 1, 'b': 2 }
```


## `head `
 Gets the first element of array.
 This attempts to replicate lodash's head.
 https://lodash.com/docs/4.17.15#head
 
 Aliases
 		GD_.first
### Arguments
 *  array (Array): The array to query.
### Example
```gdscript
GD_.head([1, 2, 3])
# => 1
 
GD_.head([])
# => null
```


## `index_of `
 Gets the index at which the first occurrence of value is found in array 
 using == for equality comparisons. If fromIndex is negative, 
 it's used as the offset from the end of array.
 This attempts to replicate lodash's indexOf.
 https://lodash.com/docs/4.17.15#indexOf

### Arguments
 *  array (Array): The array to inspect.
 *  value (*): The value to search for.
 *  [fromIndex=0] (number): The index to search from.
### Example
```gdscript
GD_.index_of([1, 2, 1, 2], 2)
# => 1
 
# Search from the `fromIndex`.
GD_.index_of([1, 2, 1, 2], 2, 2)
# => 3
```


## `initial `
 Gets all but the last element of array.
 This attempts to replicate lodash's initial.
 https://lodash.com/docs/4.17.15#initial

### Arguments
 *  array (Array): The array to query.
### Example
```gdscript
GD_.initial([1, 2, 3])
# => [1, 2]
```


## `intersection `
 Creates an array of unique values that are included in all given 
 arrays using == for equality comparisons. The order and references of 
 result values are determined by the first array.
 This attempts to replicate lodash's intersection.
 https://lodash.com/docs/4.17.15#intersection

### Arguments
 *  [arrays] (...Array): The arrays to inspect.
### Example
```gdscript
 GD_.intersection([2, 1], [2, 3])
 # => [2]
```


## `intersection_by `
 This method is like GD_.intersection except that it accepts iteratee 
 which is invoked for each element of each arrays to generate the 
 criterion by which they're compared. The order and references of result 
 values are determined by the first array. The iteratee is invoked 
 with one argument: (value)
 This attempts to replicate lodash's intersectionBy.
 https://lodash.com/docs/4.17.15#intersectionBy

### Arguments
 *  [arrays] (...Array): The arrays to inspect.
 *  [iteratee=GD_.identity] (Function): The iteratee invoked per element.
### Example
```gdscript
GD_.intersection_by([2.1, 1.2], [2.3, 3.4], GD_.floor)
# => [2.1]
 
# The `GD_.property` iteratee shorthand.
GD_.intersection_by([{ 'x': 1 }], [{ 'x': 2 }, { 'x': 1 }], 'x')
# => [{ 'x': 1 }]
```


## `intersection_with `
 This method is like GD_.intersection except that it accepts comparator 
 which is invoked to compare elements of arrays. The order and references of 
 result values are determined by the first array. The comparator is invoked 
 with two arguments: (arrVal, othVal).
 You can "intersect" with up to 10 values. Hopefully thats enough
 This attempts to replicate lodash's intersectionWith.
 https://lodash.com/docs/4.17.15#intersectionWith
 
### Arguments
 *  [arrays] (...Array): The arrays to inspect.
 *  [comparator] (Function): The comparator invoked per element.
### Example
```gdscript
 var objects = [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]
 var others = [{ 'x': 1, 'y': 1 }, { 'x': 1, 'y': 2 }]
  
 GD_.intersection_with(objects, others, GD_.is_equal)
 # => [{ 'x': 1, 'y': 2 }]
```


## `join `
 Converts all elements in array into a string separated by separator.
 This attempts to replicate lodash's join.
 https://lodash.com/docs/4.17.15#join
 
### Arguments
 *  array (Array): The array to convert.
 *  [separator=','] (string): The element separator.
### Example
```gdscript
 GD_.join(['a', 'b', 'c'], '~')
 # => 'a~b~c'
```


## `last `
 Gets the last element of array.
 This attempts to replicate lodash's last.
 https://lodash.com/docs/4.17.15#last

### Arguments
 *  array (Array): The array to query.
### Example
```gdscript
 GD_.last([1, 2, 3])
 # => 3
```


## `last_index_of `
 This method is like GD_.index_of except that it iterates 
 over elements of array from right to left.
 This attempts to replicate lodash's lastIndexOf.
 https://lodash.com/docs/4.17.15#lastIndexOf

### Arguments
 *  array (Array): The array to inspect.
 *  value (*): The value to search for.
 *  [fromIndex=array.length-1] (number): The index to search from.
### Example
```gdscript
 GD_.last_index_of([1, 2, 1, 2], 2)
 # => 3
  
 # Search from the from_index`.
 GD_.last_index_of([1, 2, 1, 2], 2, 2)
 # => 1
```


## `nth `
 Gets the element at index n of array. 
 If n is negative, the nth element from the end is returned.
 This attempts to replicate lodash's nth.
 https://lodash.com/docs/4.17.15#nth
 
### Arguments
 *  array (Array): The array to query.
 *  [n=0] (number): The index of the element to return.
### Example
```gdscript
 var array = ['a', 'b', 'c', 'd']
  
 GD_.nth(array, 1)
 # => 'b'
  
 GD_.nth(array, -2)
 # => 'c'
```


## `pull `
 Removes all given values from array using == for equality comparisons.

 Note: Unlike _.without, this method mutates array. 
 Use _.remove to remove elements from an array by predicate
 This attempts to replicate lodash's pull.
 https://lodash.com/docs/4.17.15#pull		

### Arguments
 *  array (Array): The array to modify.
 *  [values] (...*): The values to remove.
### Example
```gdscript
 var array = ['a', 'b', 'c', 'a', 'b', 'c']
  
 GD_.pull(array, 'a', 'c')
 print(array)
 # => ['b', 'b']
```


## `pull_all `
 This method is like _.pull except that it accepts an array of values to remove.
 Note: Unlike _.difference, this method mutates array.
 This attempts to replicate lodash's pullAll.
 https://lodash.com/docs/4.17.15#pullAll
 
### Arguments
 *  array (Array): The array to modify.
 *  values (Array): The values to remove.
### Example
```gdscript
 var array = ['a', 'b', 'c', 'a', 'b', 'c']
  
 GD_.pull_all(array, ['a', 'c'])
 print(array)
 # => ['b', 'b']
```


## `pull_all_by `
 This method is like GD_.pull_all except that it accepts iteratee 
 which is invoked for each element of array and values to generate 
 the criterion by which they're compared. The iteratee is invoked 
 with one argument: (value).
 Note: Unlike GD_.difference_by, this method mutates array.	
 This attempts to replicate lodash's pullAllBy.
 https://lodash.com/docs/4.17.15#pullAllBy

### Arguments
 *  array (Array): The array to modify.
 *  values (Array): The values to remove.
 *  [iteratee=_.identity] (Function): The iteratee invoked per element.
### Example
```gdscript
 var array = [{ 'x': 1 }, { 'x': 2 }, { 'x': 3 }, { 'x': 1 }]
  
 GD_.pull_all_by(array, [{ 'x': 1 }, { 'x': 3 }], 'x')
 # => [{ 'x': 2 }]
```


## `pull_all_with `
 This method is like GD_.pull_all except that it accepts comparator which 
 is invoked to compare elements of array to values. The comparator is 
 invoked with two arguments: (arrVal, othVal).
 Note: Unlike GD_.difference_with, this method mutates array.
 This attempts to replicate lodash's pullAllWith.
 https://lodash.com/docs/4.17.15#pullAllWith

### Arguments
 *  array (Array): The array to modify.
 *  values (Array): The values to remove.
 *  [comparator] (Function): The comparator invoked per element.
### Example
```gdscript
 var array = [{ 'x': 1, 'y': 2 }, { 'x': 3, 'y': 4 }, { 'x': 5, 'y': 6 }]
  
 GD_.pull_all_with(array, [{ 'x': 3, 'y': 4 }], GD_.is_equal)
 print(array)
 # => [{ 'x': 1, 'y': 2 }, { 'x': 5, 'y': 6 }]
```


## `pull_at `
 Removes elements from array corresponding to indexes and returns 
 an array of removed elements.
 
 Note: Unlike GD_.at, this method mutates array.
 This attempts to replicate lodash's pullAt.
 https://lodash.com/docs/4.17.15#pullAt
 
### Arguments
 *  array (Array): The array to modify.
 *  [indexes] (...(number|number[])): The indexes of elements to remove.
### Example
```gdscript
 var array = ['a', 'b', 'c', 'd']
 var pulled = GD_.pull_at(array, [1, 3])
  
 print(array)
 # => ['a', 'c']
  
 print(pulled)
 # => ['b', 'd']
```


## `remove `
 Removes all elements from array that predicate returns truthy for 
 and returns an array of the removed elements. The predicate is invoked 
 with two arguments: (value, index).
 Note: Unlike GD_.filter, this method mutates array. 
 Use GD_.pull to pull elements from an array by value.
 
 This attempts to replicate lodash's remove.
 https://lodash.com/docs/4.17.15#remove
 
### Arguments
 *  array (Array): The array to modify.
 *  [predicate=GD_.identity] (Function): The function invoked per iteration.
### Example
```gdscript
 var array = [1, 2, 3, 4]
 var evens = GD_.remove(array, func(n, _i):
 	return n % 2 == 0
 )
  	
 print(array)
 # => [1, 3]
  
 print(evens)
 # => [2, 4]
```


## `reverse `
 Reverses array so that the first element becomes the last, the second element 
 becomes the second to last, and so on.
 Note: This is a wrapper on Godot's Array.reverse()

 This attempts to replicate lodash's reverse.
 https://lodash.com/docs/4.17.15#reverse

### Arguments
 *  array (Array): The array to modify.
### Example
```gdscript
 var array = [1, 2, 3]
  
 GD_.reverse(array)
 # => [3, 2, 1]
  
 print(array)
 # => [3, 2, 1]
```


## `slice `
 Creates a slice of array from start up to, but not including, end.
 
 Note: This method is a wrapper for Godot's Array.slice
 This attempts to replicate lodash's slice.
 https://lodash.com/docs/4.17.15#slice
 
### Arguments
 *  array (Array): The array to slice.
 *  [start=0] (number): The start position.
 *  [end=array.length] (number): The end position.
### Example
```gdscript
var array = [0,1,2,3,4]
var slice = GD_.slice(array,1,4)

print(slice)
# => [1,2,3]
```


## `sorted_index `
 Uses a binary search to determine the lowest index at which 
 value should be inserted into array in order to maintain its sort order.
 
 This attempts to replicate lodash's sortedIndex.
 https://lodash.com/docs/4.17.15#sortedIndex
 
### Arguments
 *  array (Array): The sorted array to inspect.
 *  value (*): The value to evaluate.
### Example
```gdscript
 GD_.sorted_index([30, 50], 40)
 # => 1
```


## `sorted_index_by `
 This method is like _.sortedIndex except that it accepts iteratee 
 which is invoked for value and each element of array to compute 
 their sort ranking. The iteratee is invoked 
 with two arguments: (value, _UNUSED_).

 This attempts to replicate lodash's sortedIndexBy.
 https://lodash.com/docs/4.17.15#sortedIndexBy

### Arguments
 *  array (Array): The sorted array to inspect.
 *  value (*): The value to evaluate.
 *  [iteratee=_.identity] (Function): The iteratee invoked per element.
### Example
```gdscript
 var objects = [{ 'x': 4 }, { 'x': 5 }]
  
 GD_.sorted_index_by(objects, { 'x': 4 }, func(o): return o.x)
 # => 0
  
 # The `GD_.property` iteratee shorthand.
 GD_.sorted_index_by(objects, { 'x': 4 }, 'x')
 # => 0 
```


## `sorted_index_of `
 This method is like _.indexOf except that it performs a binary 
 search on a sorted array.
 
 This attempts to replicate lodash's sortedIndexOf.
 https://lodash.com/docs/4.17.15#sortedIndexOf
 
### Arguments
 *  array (Array): The array to inspect.
 *  value (*): The value to search for.
### Example
```gdscript
 GD _.sorted_index_of([4, 5, 5, 5, 6], 5)
 # => 1	
```


## `sorted_last_index `
 This method is like GD_.sorted_index except that it returns the 
 highest index at which value should be inserted into array in 
 order to maintain its sort order.
 
 This attempts to replicate lodash's sortedLastIndex.
 https://lodash.com/docs/4.17.15#sortedLastIndex
 
### Arguments
 *  array (Array): The sorted array to inspect.
 *  value (*): The value to evaluate.
### Example
```gdscript
 GD_.sorted_last_index([4, 5, 5, 5, 6], 5)
 # => 4
```


## `sorted_last_index_by `
 This method is like GD_.sorted_last_index except that it accepts iteratee 
 which is invoked for value and each element of array to compute 
 their sort ranking. The iteratee is invoked 
 with two arguments: (value, _UNUSED_).

 This attempts to replicate lodash's sortedLastIndexBy.
 https://lodash.com/docs/4.17.15#sortedLastIndexBy
 
### Arguments
 *  array (Array): The sorted array to inspect.
 *  value (*): The value to evaluate.
 *  [iteratee=GD_.identity] (Function): The iteratee invoked per element.
### Example
```gdscript
 var objects = [{ 'x': 4 }, { 'x': 5 }]
 GD_.sorted_last_index_by(objects, { 'x': 4 }, func(o,_u): return o.x)
 # => 1
  
 # The `GD_.property` iteratee shorthand.
 GD_.sorted_last_index_by(objects, { 'x': 4 }, 'x')
 # => 1
```


## `sorted_last_index_of `
 This method is like _.lastIndexOf except that it performs a binary search on a sorted array.

 This attempts to replicate lodash's sortedLastIndexBy.
 https://lodash.com/docs/4.17.15#sortedLastIndexBy
 
### Arguments
 *  array (Array): The array to inspect.
 *  value (*): The value to search for.
### Example
```gdscript
 GD_.sorted_last_index_of([4, 5, 5, 5, 6], 5)
 # => 3
```


## `sorted_uniq `
 This method is like GD_.uniq except that it's designed 
 and optimized for sorted arrays.

 This attempts to replicate lodash's sortedUniq.
 https://lodash.com/docs/4.17.15#sortedUniq

### Arguments
 *  array (Array): The array to inspect.
### Example
```gdscript
 GD_.sorted_uniq([1, 1, 2])
 # => [1, 2]
```


## `sorted_uniq_by `
 This method is like GD_.uniq_by except that it's designed and 
 optimized for sorted arrays.
 
 This attempts to replicate lodash's sortedUniqBy.
 https://lodash.com/docs/4.17.15#sortedUniqBy
 
### Arguments
 *  array (Array): The array to inspect.
 *  [iteratee] (Function): The iteratee invoked per element.
### Example
```gdscript
 GD_.sorted_uniq_by([1.1, 1.2, 2.3, 2.4], Math.floor)
 # => [1.1, 2.3]
```


## `tail `
 Gets all but the first element of array.
 
 This attempts to replicate lodash's tail.
 https://lodash.com/docs/4.17.15#tail
 
### Arguments
 *  array (Array): The array to query.
### Example
```gdscript
 GD_.tail([1, 2, 3])
 # => [2, 3]
```


## `take `
 Creates a slice of array with n elements taken from the beginning.
 
 This attempts to replicate lodash's take.
 https://lodash.com/docs/4.17.15#take

### Arguments
 *  array (Array): The array to query.
 *  [n=1] (number): The number of elements to take.
### Example
```gdscript
 GD_.take([1, 2, 3])
 # => [1]
  
 GD_.take([1, 2, 3], 2)
 # => [1, 2]
  
 GD_.take([1, 2, 3], 5)
 # => [1, 2, 3]
  
 GD_.take([1, 2, 3], 0)
 # => []
```


## `take_right `
> NOT YET IMPLEMENTED
## `take_right_while `
> NOT YET IMPLEMENTED
## `take_while `
> NOT YET IMPLEMENTED
## `union `
> NOT YET IMPLEMENTED
## `union_by `
> NOT YET IMPLEMENTED
## `union_with `
> NOT YET IMPLEMENTED
## `uniq `
 Creates a duplicate-free version of an array, using == for equality 
 comparisons, in which only the first occurrence of each element is kept. 
 The order of result values is determined by the order 
 they occur in the array.

 This attempts to replicate lodash's uniq.
 https://lodash.com/docs/4.17.15#uniq
 
### Arguments
 *  array (Array): The array to inspect.
### Example
```gdscript
 GD_.uniq([2, 1, 2])
 # => [2, 1]
```


## `uniq_by `
 This method is like GD_.uniq except that it accepts iteratee which 
 is invoked for each element in array to generate the criterion by 
 which uniqueness is computed. The order of result values is determined 
 by the order they occur in the array. The iteratee is invoked 
 with two arguments : (value, _UNUSED_).
 
 This attempts to replicate lodash's uniq.
 https://lodash.com/docs/4.17.15#uniq
 
### Arguments
 *  array (Array): The array to inspect.
 *  [iteratee=GD_.identity] (Function): The iteratee invoked per element.
### Example
```gdscript
 GD_.uniq_by([2.1, 1.2, 2.3], Math.floor)
 # => [2.1, 1.2]
  
 # The `GD_.property` iteratee shorthand.
 GD_.uniq_by([{ 'x': 1 }, { 'x': 2 }, { 'x': 1 }], 'x')
 # => [{ 'x': 1 }, { 'x': 2 }]
```


## `uniq_with `
 This method is like GD_.uniq except that it accepts comparator 
 which is invoked to compare elements of array. The order of result values 
 is determined by the order they occur in the array. The 
 comparator is invoked with two arguments: (arrVal, othVal).
 
 This attempts to replicate lodash's uniq.
 https://lodash.com/docs/4.17.15#uniq
 
### Arguments
 *  array (Array): The array to inspect.
 *  [comparator] (Function): The comparator invoked per element.
### Example
```gdscript
 var objects = [{'x':1,'y':2},{'x':2,'y':1},{'x':1,'y':2}]
 GD_.uniq_with(objects, GD_.is_equal)
 # => [{ 'x': 1, 'y': 2 }, { 'x': 2, 'y': 1 }]	
```


## `unzip `
> NOT YET IMPLEMENTED
## `unzip_with `
> NOT YET IMPLEMENTED
## `without `
> NOT YET IMPLEMENTED
## `xor `
> NOT YET IMPLEMENTED
## `xor_by `
> NOT YET IMPLEMENTED
## `xor_with `
> NOT YET IMPLEMENTED
## `zip `
> NOT YET IMPLEMENTED
## `zip_object `
> NOT YET IMPLEMENTED
## `zip_object_deep `
> NOT YET IMPLEMENTED
## `zip_with `
> NOT YET IMPLEMENTED
## `count_by `
 Creates a dictionary composed of keys generated from the results of 
 running each element of collection thru iteratee. The corresponding value 
 of each key is the number of times the key was returned by iteratee. 
 The iteratee is invoked with two arguments: (value, _UNUSED_).
 This attempts to replicate lodash's count_by. 
 See https://lodash.com/docs/4.17.15#countBy

### Arguments
 *  collection (Array|Object): The collection to iterate over.
 *  [iteratee=GD_.identity] (Function): The iteratee to transform keys.
### Example
```gdscript
 GD_.count_by([6.1, 4.2, 6.3], GD_.floor)
 # => { '4': 1, '6': 2 }
  
 # The `GD_.property` iteratee shorthand.
 GD_.count_by(['one', 'two', 'three'], 'length')
 # => { '3': 2, '5': 1 }
```


## `each `
 Alias of for_each
 This attempts to replicate lodash's each.
 https://lodash.com/docs/4.17.15#each


## `for_each `
 Iterates over elements of collection and invokes iteratee for each element. 
 The iteratee is invoked with two arguments: (value, index|key). 
 Iteratee functions may exit iteration early by explicitly returning false.

 Aliases
 		GD_.each
### Arguments
 *  collection (Array|Object): The collection to iterate over.
 *  [iteratee=GD_.identity] (Function): The function invoked per iteration.
### Example
```gdscript
 GD_.for_each([1, 2], func (value,_index): print(value))
 # => Logs `1` then `2`.
  
 GD_.for_each({ 'a': 1, 'b': 2 }, func (_value, key): print(key))
 # => Logs 'a' then 'b' (iteration order is not guaranteed).
```


## `each_right `
> NOT YET IMPLEMENTED
## `every `
> NOT YET IMPLEMENTED
## `filter `
 Iterates over elements of collection, returning an array of all elements predicate returns truthy for. 
 The predicate is invoked with two arguments (value, index|key).
 This attempts to replicate lodash's filter. 
 See https://lodash.com/docs/4.17.15#filter

### Arguments
 *  collection (Array|Object): The collection to iterate over.
 *  [predicate=GD_.identity] (Function): The function invoked per iteration.
### Example
```gdscript
 var users = [
   { 'user': 'barney', 'age': 36, 'active': true },
   { 'user': 'fred',   'age': 40, 'active': false }
 ]
  
 GD_.filter(users, func(o,_index): return !o.active)
 # => objects for ['fred']
  
 # The `GD_.matches` iteratee shorthand.
 GD_.filter(users, { 'age': 36, 'active': true })
 # => objects for ['barney']
  
 # The `GD_.matches_property` iteratee shorthand.
 GD_.filter(users, ['active', false])
 # => objects for ['fred']
  
 # The `GD_.property` iteratee shorthand.
 GD_.filter(users, 'active')
 # => objects for ['barney']
```


## `find `
 Iterates over elements of collection, returning the first element predicate returns truthy for.
 The predicate is invoked with two arguments: (value, index|key).
 This attempts to replicate lodash's find.
 See https://lodash.com/docs/4.17.15#find
 
### Arguments
 *  collection (Array|Object): The collection to inspect.
 *  [predicate=GD_.identity] (Function): The function invoked per iteration.
 *  [fromIndex=0] (number): The index to search from.
### Example
```gdscript
 var users = [
   { 'user': 'barney',  'age': 36, 'active': true },
   { 'user': 'fred',    'age': 40, 'active': false },
   { 'user': 'pebbles', 'age': 1,  'active': true }
 ]
  
 GD_.find(users, func(o,_index): return o.age < 40)
 # => object for 'barney'
  
 # The `GD_.matches` iteratee shorthand.
 GD_.find(users, { 'age': 1, 'active': true })
 # => object for 'pebbles'
  
 # The `GD_.matches_property` iteratee shorthand.
 GD_.find(users, ['active', false])
 # => object for 'fred'
  
 # The `GD_.property` iteratee shorthand.
 GD_.find(users, 'active')
 # => object for 'barney'
```


## `find_last `
> NOT YET IMPLEMENTED
## `flat_map `
> NOT YET IMPLEMENTED
## `flat_map_deep `
> NOT YET IMPLEMENTED
## `flat_map_depth `
> NOT YET IMPLEMENTED
## `for_each_right `
> NOT YET IMPLEMENTED
## `group_by `
 Creates a dictionary composed of keys generated from the results of 
 running each element of collection thru iteratee. The order of grouped values is 
 determined by the order they occur in collection. The corresponding value 
 of each key is an array of elements responsible for generating the key. 
 The iteratee is invoked with two arguments: (value, _UNUSED_).
 This attempts to replicate lodash's groupBy.
 See https://lodash.com/docs/4.17.15#groupBy

### Arguments
 *  collection (Array|Object): The collection to iterate over.
 *  [iteratee=GD_.identity] (Function): The iteratee to transform keys.
### Example
```gdscript
 GD_.group_by([6.1, 4.2, 6.3], GD_.floor)
 # => { '4': [4.2], '6': [6.1, 6.3] }
  
 # The `_.property` iteratee shorthand.
 GD_.group_by(['one', 'two', 'three'], 'length')
 # => { '3': ['one', 'two'], '5': ['three'] }
```


## `includes `
> NOT YET IMPLEMENTED
## `invoke_map `
> NOT YET IMPLEMENTED
## `key_by `
> NOT YET IMPLEMENTED
## `map `
 Creates an array of values by running each element in collection thru 
 iteratee. The iteratee is invoked with two arguments: (value, index|key).
 The iteratee is invoked with two arguments: (value, index).
 This attempts to replicate lodash's map.
 See https://lodash.com/docs/4.17.15#map

### Arguments
 *  collection (Array|Object): The collection to iterate over.
 *  [iteratee=GD_.identity] (Function): The function invoked per iteration.
### Example
```gdscript
 func square(n, _index):
 	  return n * n
  
 GD_.map([4, 8], square)
 # => [16, 64]
  
 GD_.map({ 'a': 4, 'b': 8 }, square)
 # => [16, 64] (iteration order is not guaranteed)
  
 var users = [
   { 'user': 'barney' },
   { 'user': 'fred' }
 ]
  
 # The `GD_.property` iteratee shorthand.
 GD_.map(users, 'user')
 # => ['barney', 'fred']
```


## `order_by `
> NOT YET IMPLEMENTED
## `partition `
> NOT YET IMPLEMENTED
## `reduce `
> NOT YET IMPLEMENTED
## `reduce_right `
> NOT YET IMPLEMENTED
## `reject `
> NOT YET IMPLEMENTED
## `sample `
> NOT YET IMPLEMENTED
## `sample_size `
> NOT YET IMPLEMENTED
## `shuffle `
> NOT YET IMPLEMENTED
## `size `
> NOT YET IMPLEMENTED
## `some `
 Checks if predicate returns truthy for any element of collection. 
 Iteration is stopped once predicate returns truthy. 
 The predicate is invoked with two arguments: (value, index|key).
 This attempts to replicate lodash's some. 
 See https://lodash.com/docs/4.17.15#some

### Arguments
 *  collection (Array|Object): The collection to iterate over.
 *  [predicate=_.identity] (Function): The function invoked per iteration.
### Example
```gdscript
 GD_.some([null, 0, 'yes', false], Boolean)
 # => true
  
 var users = [
   { 'user': 'barney', 'active': true },
   { 'user': 'fred',   'active': false }
 ]
  
 # The `GD_.matches` iteratee shorthand.
 GD_.some(users, { 'user': 'barney', 'active': false })
 # => false
  
 # The `GD_.matches_property` iteratee shorthand.
 GD_.some(users, ['active', false])
 # => true
  
 # The `GD_.property` iteratee shorthand.
 GD_.some(users, 'active')
 # => true
```


## `sort_by `
> NOT YET IMPLEMENTED
## `now `
> NOT YET IMPLEMENTED
## `after `
> NOT YET IMPLEMENTED
## `ary `
> NOT YET IMPLEMENTED
## `before `
> NOT YET IMPLEMENTED
## `bind `
> NOT YET IMPLEMENTED
## `bind_key `
> NOT YET IMPLEMENTED
## `curry `
> NOT YET IMPLEMENTED
## `curry_right `
> NOT YET IMPLEMENTED
## `debounce `
> NOT YET IMPLEMENTED
## `defer `
> NOT YET IMPLEMENTED
## `delay `
> NOT YET IMPLEMENTED
## `flip `
> NOT YET IMPLEMENTED
## `memoize `
> NOT YET IMPLEMENTED
## `negate `
> NOT YET IMPLEMENTED
## `once `
> NOT YET IMPLEMENTED
## `over_args `
> NOT YET IMPLEMENTED
## `partial `
> NOT YET IMPLEMENTED
## `partial_right `
> NOT YET IMPLEMENTED
## `rearg `
> NOT YET IMPLEMENTED
## `rest `
> NOT YET IMPLEMENTED
## `spread `
> NOT YET IMPLEMENTED
## `throttle `
> NOT YET IMPLEMENTED
## `unary `
> NOT YET IMPLEMENTED
## `wrap_func `
> NOT YET IMPLEMENTED
## `cast_array `
 Casts value as an array if it's not one.
 This attempts to replicate lodash's castArray. 
 See https://lodash.com/docs/4.17.15#castArray

### Arguments
 *  value (*): The value to inspect.
### Example
```gdscript
 GD_.castArray(1)
 # => [1]
  
 GD_.castArray({ 'a': 1 })
 # => [{ 'a': 1 }]
  
 GD_.castArray('abc')
 # => ['abc']
  
 GD_.castArray(null)
 # => [null]
  
 GD_.castArray(null)
 # => [null]
  
 GD_.castArray()
 # => []
  
 var array = [1, 2, 3]
 print(GD_.castArray(array) == array)
 # => true
```


## `clone `
> NOT YET IMPLEMENTED
## `clone_deep `
> NOT YET IMPLEMENTED
## `clone_deep_with `
> NOT YET IMPLEMENTED
## `clone_with `
> NOT YET IMPLEMENTED
## `conforms_to `
> NOT YET IMPLEMENTED
## `eq `
 Basically a lambda wrapper for `==`. Because of the way dicts and
 arrays implement the "==" operators, it results in a deep comparison.
 So GD_.is_equal, GD_.eq, and ==, have all the same results
 This attempts to replicate lodash's eq. 
 See https://lodash.com/docs/4.17.15#eq


## `gt `
 Checks if value is greater than other.
 This attempts to replicate lodash's gt. 
 See https://lodash.com/docs/4.17.15#gt

### Arguments
 *  value (*): The value to compare.
 *  other (*): The other value to compare.
### Example
```gdscript
 GD_.gt(3, 1)
 # => true
 GD 
 GD_.gt(3, 3)
 # => false
 GD 
 GD_.gt(1, 3)
 # => false
```


## `gte `
 Checks if value is greater than other.
 This attempts to replicate lodash's gte. 
 See https://lodash.com/docs/4.17.15#gte

### Arguments
 *  value (*): The value to compare.
 *  other (*): The other value to compare.
### Example
```gdscript
 GD_.gte(3, 1)
 # => true
  
 GD_.gte(3, 3)
 # => true
  
 GD_.gte(1, 3)
 # => false
```


## `is_arguments `
> NOT YET IMPLEMENTED
## `is_array `
> NOT YET IMPLEMENTED
## `is_array_buffer `
> NOT YET IMPLEMENTED
## `is_array_like `
> NOT YET IMPLEMENTED
## `is_array_like_object `
> NOT YET IMPLEMENTED
## `is_boolean `
> NOT YET IMPLEMENTED
## `is_buffer `
> NOT YET IMPLEMENTED
## `is_date `
> NOT YET IMPLEMENTED
## `is_element `
> NOT YET IMPLEMENTED
## `is_empty `
> NOT YET IMPLEMENTED
## `is_equal `
 Basically a lambda wrapper for `==`. Because of the way dicts and
 arrays implement the "==" operators, it results in a deep comparison.
 So GD_.is_equal, GD_.eq, and ==, have all the same results
 This attempts to replicate lodash's isEqual. 
 See https://lodash.com/docs/4.17.15#isEqual


## `is_equal_with `
> NOT YET IMPLEMENTED
## `is_error `
> NOT YET IMPLEMENTED
## `is_function `
> NOT YET IMPLEMENTED
## `is_integer `
> NOT YET IMPLEMENTED
## `is_length `
> NOT YET IMPLEMENTED
## `is_map `
> NOT YET IMPLEMENTED
## `is_match `
> NOT YET IMPLEMENTED
## `is_match_with `
> NOT YET IMPLEMENTED
## `is_native `
> NOT YET IMPLEMENTED
## `is_nil `
> NOT YET IMPLEMENTED
## `is_null `
> NOT YET IMPLEMENTED
## `is_number `
 Checks if value is classified as a Number primitive 
 Note: To exclude Infinity, -Infinity, and NaN, which are classified 
 as numbers, use the _.isFinite method.
 
 This attempts to replicate lodash's isNumber. 
 See https://lodash.com/docs/4.17.15#isNumber
 
### Arguments
 *  value (*): The value to check.
### Example
```gdscript
 GD_.is_number(3)
 # => true
  
 GD_.is_number(Number.MIN_VALUE)
 # => true
  
 GD_.is_number(Infinity)
 # => true
  
 GD_.is_number('3')
 # => false
```


## `is_object `
> NOT YET IMPLEMENTED
## `is_object_like `
> NOT YET IMPLEMENTED
## `is_plain_object `
> NOT YET IMPLEMENTED
## `is_reg_exp `
> NOT YET IMPLEMENTED
## `is_safe_integer `
> NOT YET IMPLEMENTED
## `is_set `
> NOT YET IMPLEMENTED
## `is_string `
> NOT YET IMPLEMENTED
## `is_symbol `
> NOT YET IMPLEMENTED
## `is_typed_array `
> NOT YET IMPLEMENTED
## `is_undefined `
> NOT YET IMPLEMENTED
## `is_weak_map `
> NOT YET IMPLEMENTED
## `is_weak_set `
> NOT YET IMPLEMENTED
## `lt `
 Checks if value is less than other.
 This attempts to replicate lodash's lt. 
 See https://lodash.com/docs/4.17.15#lt
### Arguments
 *  value (*): The value to compare.
 *  other (*): The other value to compare.
### Example
```gdscript
 GD_.lt(1, 3)
 # => true
  
 GD_.lt(3, 3)
 # => false
  
 GD_.lt(3, 1)
 # => false
```


## `lte `
 Checks if value is less than other.
 This attempts to replicate lodash's lt. 
 See https://lodash.com/docs/4.17.15#lt
### Arguments
 *  value (*): The value to compare.
 *  other (*): The other value to compare.
### Example
```gdscript
 GD_.lt(1, 3)
 # => true
  
 GD_.lt(3, 3)
 # => false
  
 GD_.lt(3, 1)
 # => false
atic func lt(a, b):
eturn a < b
```


## `to_array `
> NOT YET IMPLEMENTED
## `to_finite `
> NOT YET IMPLEMENTED
## `to_integer `
> NOT YET IMPLEMENTED
## `to_length `
> NOT YET IMPLEMENTED
## `to_number `
> NOT YET IMPLEMENTED
## `to_plain_object `
> NOT YET IMPLEMENTED
## `to_safe_integer `
> NOT YET IMPLEMENTED
## `add `
> NOT YET IMPLEMENTED
## `divide `
> NOT YET IMPLEMENTED
## `floor `
 Computes number rounded down to precision. This uses Godot's floor
 internally but precision can be added.
 This attempts to replicate lodash's floor. 
 See https://lodash.com/docs/4.17.15#floor

### Arguments
 *  number (number): The number to round down.
 *  [precision=0] (number): The precision to round down to.
### Example
```gdscript
 GD_.floor(4.006)
 # => 4
  
 GD_.floor(0.046, 2)
 # => 0.04
  
 GD_.floor(4060, -2)
 # => 4000
```


## `max_by `
> NOT YET IMPLEMENTED
## `mean `
> NOT YET IMPLEMENTED
## `mean_by `
> NOT YET IMPLEMENTED
## `min_by `
> NOT YET IMPLEMENTED
## `multiply `
> NOT YET IMPLEMENTED
## `subtract `
> NOT YET IMPLEMENTED
## `sum `
> NOT YET IMPLEMENTED
## `sum_by `
> NOT YET IMPLEMENTED
## `in_range `
> NOT YET IMPLEMENTED
## `random `
> NOT YET IMPLEMENTED
## `assign `
> NOT YET IMPLEMENTED
## `assign_in `
> NOT YET IMPLEMENTED
## `assign_in_with `
> NOT YET IMPLEMENTED
## `assign_with `
> NOT YET IMPLEMENTED
## `at `
> NOT YET IMPLEMENTED
## `create `
> NOT YET IMPLEMENTED
## `defaults `
> NOT YET IMPLEMENTED
## `defaults_deep `
> NOT YET IMPLEMENTED
## `to_pairs `
> NOT YET IMPLEMENTED
## `to_pairs_in `
> NOT YET IMPLEMENTED
## `find_key `
> NOT YET IMPLEMENTED
## `find_last_key `
> NOT YET IMPLEMENTED
## `for_in `
> NOT YET IMPLEMENTED
## `for_in_right `
> NOT YET IMPLEMENTED
## `for_own `
> NOT YET IMPLEMENTED
## `for_own_right `
> NOT YET IMPLEMENTED
## `functions `
> NOT YET IMPLEMENTED
## `functions_in `
> NOT YET IMPLEMENTED
## `get_prop `
 Gets the value at path of object. If the resolved value is null, 
 the defaultValue is returned in its place.
 This is similar to lodash's get but renamed due to name clashes.
 This attempts to replicate lodash's get. 
 See https://lodash.com/docs/4.17.15#get

### Arguments
 *  object (Object): The object to query.
 *  path (Array|string): The path of the property to get.
 *  [defaultValue] (*): The value returned for null resolved values.
### Example
```gdscript
 var object = { 'a': [{ 'b': { 'c': 3 } }] }
  
 GD_.get_prop(object, 'a:3:b:c')
 # => 3
  
 GD_.get_prop(object, ['a', '0', 'b', 'c'])
 # => 3
  
 GD_.get_prop(object, 'a:b:c', 'default')
 # => 'default'
```


## `has `
> NOT YET IMPLEMENTED
## `has_in `
> NOT YET IMPLEMENTED
## `invert `
> NOT YET IMPLEMENTED
## `invert_by `
> NOT YET IMPLEMENTED
## `invoke `
> NOT YET IMPLEMENTED
## `keys `
> NOT YET IMPLEMENTED
## `keys_in `
> NOT YET IMPLEMENTED
## `map_keys `
> NOT YET IMPLEMENTED
## `map_values `
> NOT YET IMPLEMENTED
## `merge `
> NOT YET IMPLEMENTED
## `merge_with `
> NOT YET IMPLEMENTED
## `omit `
> NOT YET IMPLEMENTED
## `omit_by `
> NOT YET IMPLEMENTED
## `pick `
> NOT YET IMPLEMENTED
## `pick_by `
> NOT YET IMPLEMENTED
## `result `
> NOT YET IMPLEMENTED
## `set_with `
> NOT YET IMPLEMENTED
## `transform `
> NOT YET IMPLEMENTED
## `unset `
> NOT YET IMPLEMENTED
## `update `
> NOT YET IMPLEMENTED
## `update_with `
> NOT YET IMPLEMENTED
## `values `
> NOT YET IMPLEMENTED
## `values_in `
> NOT YET IMPLEMENTED
## `attempt `
> NOT YET IMPLEMENTED
## `bind_all `
> NOT YET IMPLEMENTED
## `cond `
> NOT YET IMPLEMENTED
## `conforms `
> NOT YET IMPLEMENTED
## `constant `
> NOT YET IMPLEMENTED
## `default_to `
 This attempts to replicate lodash's defaultTo. 
 https://lodash.com/docs/4.17.15#defaultTo
 
### Arguments
 *  value (*): The value to check.
 *  defaultValue (*): The default value.
### Example
```gdscript
 GD_.default_to(1, 10)
 # => 1
  
 GD_.default_to(null, 10)
 # => 10
```


## `flow `
> NOT YET IMPLEMENTED
## `flow_right `
> NOT YET IMPLEMENTED
## `identity `
 This method returns the first argument it receives.
 This attempts to replicate lodash's identity. 
 https://lodash.com/docs/4.17.15#identity
 
### Arguments
 *  value (*): Any value.
### Example
```gdscript
 var object = { 'a': 1 }
  
 print(is_same(GD_.identity(object),object))
 # => true
```


## `iteratee `
 Converts shorthands to callables for use in other funcs
 This attempts to replicate lodash's iteratee. 
 https://lodash.com/docs/4.17.15#iteratee

### Arguments
 *  [func=GD_.identity] (*): The value to convert to a callback.
### Example
```gdscript
 var users = [
   { 'user': 'barney', 'age': 36, 'active': true },
   { 'user': 'fred',   'age': 40, 'active': false }
 ]
  
 # The `GD_.matches` iteratee shorthand.
 GD_.filter(users, GD_.iteratee({ 'user': 'barney', 'active': true }))
 # => [{ 'user': 'barney', 'age': 36, 'active': true }]
  
 # The `GD_.matches_property` iteratee shorthand.
 GD_.filter(users, GD_.iteratee(['user', 'fred']))
 # => [{ 'user': 'fred', 'age': 40 }]
  
 # The `GD_.property` iteratee shorthand.
 GD_.map(users, GD_.iteratee('user'))
 # => ['barney', 'fred']
```


## `matches `
 Creates a function that perform a comparison between a 
 given object and source, returning true if the given object has equivalent 
 property values, else false.
 This attempts to replicate lodash's matches. 
 https://lodash.com/docs/4.17.15#matches

### Arguments
 *  source (Object): The object of property values to match.
### Example
```gdscript
 var objects = [
   { 'a': 1, 'b': 2, 'c': 3 },
   { 'a': 4, 'b': 5, 'c': 6 }
 ]
  
 GD_.filter(objects, _.matches({ 'a': 4, 'c': 6 }))
 # => [{ 'a': 4, 'b': 5, 'c': 6 }]
```


## `matches_property `
 Creates a function that performs a partial deep comparison between 
 the value at path of a given object to srcValue, returning true if the 
 object value is equivalent, else false. Note: Partial comparisons will 
 match empty array and empty object srcValue values against any array 
 or object value, respectively. 
 This attempts to replicate lodash's matches_property. 
 https://lodash.com/docs/4.17.15#matches_property
 
### Arguments
 *  path (Array|string): The path of the property to get.
 *  srcValue (*): The value to match.
### Example
```gdscript
 var objects = [
   { 'a': 1, 'b': 2, 'c': 3 },
   { 'a': 4, 'b': 5, 'c': 6 }
 ]
  
 GD_.find(objects, GD_.matches_property('a', 4))
 # => { 'a': 4, 'b': 5, 'c': 6 }
```


## `method `
> NOT YET IMPLEMENTED
## `method_of `
> NOT YET IMPLEMENTED
## `mixin `
> NOT YET IMPLEMENTED
## `no_conflict `
> NOT YET IMPLEMENTED
## `noop `
 This method returns null.

 This attempts to replicate lodash's noop. 
 https://lodash.com/docs/4.17.15#noop

### Example
```gdscript
 GD_.times(2, GD_.noop)
 # => [null, null]
```


## `nth_arg `
> NOT YET IMPLEMENTED
## `over `
> NOT YET IMPLEMENTED
## `over_every `
> NOT YET IMPLEMENTED
## `over_some `
> NOT YET IMPLEMENTED
## `property `
 Creates a function that returns the value at path of a given object.	

 This attempts to replicate lodash's iteratee. 
 https://lodash.com/docs/4.17.15#iteratee

### Arguments
 *  path (Array|string): The path of the property to get.
### Example
```gdscript
 var objects = [
   { 'a': { 'b': 2 } },
   { 'a': { 'b': 1 } }
 ]
  
 GD_.map(objects, GD_.property('a:b'))
 # => [2, 1]
 
var node = Node2D.new()
node.global_position = Vector2(15,10)
var fn = GD_.property("global_position:x")
fn.call(node) 
# => 15
```


## `property_of `
> NOT YET IMPLEMENTED
## `range_right `
> NOT YET IMPLEMENTED
## `run_in_context `
> NOT YET IMPLEMENTED
## `stub_array `
> NOT YET IMPLEMENTED
## `stub_false `
> NOT YET IMPLEMENTED
## `stub_object `
> NOT YET IMPLEMENTED
## `stub_string `
> NOT YET IMPLEMENTED
## `stub_true `
> NOT YET IMPLEMENTED
## `times `
 Invokes the iteratee n times, returning an array of the results of 
 each invocation. The iteratee is invoked with two args (index, _UNUSED_)
 
 This attempts to replicate lodash's times. 
 https://lodash.com/docs/4.17.15#times
 
### Arguments
 *  n (number): The number of times to invoke iteratee.
 *  [iteratee=GD_.identity] (Function): The function invoked per iteration.
### Example
```gdscript
 GD_.times(3, String)
 # => ['0', '1', '2']
  
  GD_.times(4, func (a,b): return 0)
 # => [0, 0, 0, 0]
```


## `to_path `
> NOT YET IMPLEMENTED
## `unique_id `
 Generates a unique ID. If prefix is given, the ID is appended to it.

 This attempts to replicate lodash's uniqueId. 
 https://lodash.com/docs/4.17.15#uniqueId

### Arguments
 *  [prefix=''] (string): The value to prefix the ID with.
### Example
```gdscript
 GD_.uniqueId('contact_')
 # => 'contact_104'
  
 GD_.uniqueId()
 # => '105'
```


