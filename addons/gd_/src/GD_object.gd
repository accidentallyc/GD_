extends "./GD_function.gd"

"""
CATEGORY: OBJECT
"""
static func assign(a=0, b=0, c=0): not_implemented() # @TODO guarded by reduce, reduceRight, transform

static func assign_in(a=0, b=0, c=0): not_implemented()

static func assign_in_with(a=0, b=0, c=0): not_implemented()

static func assign_with(a=0, b=0, c=0): not_implemented()


## Creates an array of values corresponding to paths of object.
## 
## 
## Arguments
## 		object (Object): The object to iterate over.
## 		[paths] (...(string|string[])): The property paths to pick.
## Returns
## 		(Array): Returns the picked values.
## Example
## 		var object = { 'a': [{ 'b': { 'c': 3 } }, 4] }
## 		 
## 		GD_.at(object, ['a[0].b.c', 'a[1]'])
## 		# => [3, 4]
##
##		GD_.at(['a', 'b', 'c'], 0,2)
##		# => ['a','c']
##
## Notes
##		>> Variable Arguments
##			In js you can call an infinite amount of args using ellipses 
##			E.g. _.at([], 1,2,3,4,5,6,7,"as many as you want",10)
##
##			But in GD_ you can call at most up to 10 args
##			E.g. GD_.at([], 1,2,3,4,5,6,7,8,9)
static func at(obj, a,b=_UNDEF_,c=_UNDEF_,d=_UNDEF_,e=_UNDEF_,f=_UNDEF_,g=_UNDEF_,h=_UNDEF_,i=_UNDEF_,j=_UNDEF_):
    return __INTERNAL__.base_at(obj, [a,b,c,d,e,f,g,h,i,j])
    

static func create(a=0, b=0, c=0): not_implemented()

static func defaults(a=0, b=0, c=0): not_implemented()

static func defaults_deep(a=0, b=0, c=0): not_implemented()

static func to_pairs(a=0, b=0, c=0): not_implemented() # alias for entries

static func to_pairs_in(a=0, b=0, c=0): not_implemented() # alias for entriesIn

static func find_key(a=0, b=0, c=0): not_implemented()

static func find_last_key(a=0, b=0, c=0): not_implemented()

static func for_in(a=0, b=0, c=0): not_implemented()

static func for_in_right(a=0, b=0, c=0): not_implemented()

static func for_own(a=0, b=0, c=0): not_implemented()

static func for_own_right(a=0, b=0, c=0): not_implemented()

static func functions(a=0, b=0, c=0): not_implemented()

static func functions_in(a=0, b=0, c=0): not_implemented()



## Gets the value at path of object. If the resolved value is null, 
## the defaultValue is returned in its place.
## This is similar to lodash's get but renamed due to name clashes.
##
##
## When using string paths, delimit them with the ":" key e.g."a:b:c"
## Or use the index access notation "a['b']['c']"
##
## Arguments
## 		object (Object): The object to query.
## 		path (Array|string): The path of the property to get.
## 		[defaultValue] (*): The value returned for null resolved values.
## Returns
## 		(*): Returns the resolved value.
## Example
## 		GD_.get_prop({ 'a': [{ 'b': { 'c': 3 } }] }, 'a:0:b:c')
## 		# => 3
## 		 
## 		GD_.get_prop({ 'a': [{ 'b': { 'c': 3 } }] }, ['a', 0, 'b', 'c'])
## 		# => 3
## 		 
## 		GD_.get_prop({ 'a': {}, 'a:b:c', 'default')
## 		# => 'default'
##
##		GD_.get_prop([1,2,[3]], '2:1') 
##		# => 3
##
##		GD_.get_prop([ {'120':'string', 120: 'number'} ], '0[120]')
##		# => number
##
##		GD_.get_prop([ {'120':'string', 120: 'number'} ], '0['120']')
##		# => string
## Notes
##		>> Regarding integer keys
##			In js ["0", -0, 0] are "the same keys" when applied to an object
##			e.g. declaring {"0":"hello",0:"world"} in JS results in  {0:"world"}
##			But in gdscript ["0"] is a different key from [-0,0]
##			e.g. declaring {"0":"hello",0:"world"} in GODOT in {"0":"hello",0:"world"} 
## 		
##			Meaning in js
##			_.get( thing, "0") == _.get( thing, -0) == _.get( thing, 0)
##			And in godot
##			_.get( thing, "0") != (_.get( thing, -0) == _.get( thing, 0))
##
##		>> Regarding function returns
##			In js you can fetch a function like this _.get([],"push")
##			But in gdscript you can't really do this without knowing that
##			The said thing is a Callable or a property
static func get_prop(thing, path, default_value = null):
    return __INTERNAL__.base_get_prop(thing, path, default_value)
    
static func has(a=0, b=0, c=0): not_implemented()

static func has_in(a=0, b=0, c=0): not_implemented()

# @TODO guarded method by map, every, filter, mapValues, reject, some
static func invert(a=0, b=0, c=0): not_implemented() 

static func invert_by(a=0, b=0, c=0): not_implemented()

static func invoke(a=0, b=0, c=0): not_implemented()

static func keys(a=0, b=0, c=0): not_implemented()

static func keys_in(a=0, b=0, c=0): not_implemented()

static func map_keys(a=0, b=0, c=0): not_implemented()

static func map_values(a=0, b=0, c=0): not_implemented()

static func merge(a=0, b=0, c=0): not_implemented()

static func merge_with(a=0, b=0, c=0): not_implemented()

static func omit(a=0, b=0, c=0): not_implemented()

static func omit_by(a=0, b=0, c=0): not_implemented()

static func pick(a=0, b=0, c=0): not_implemented()

static func pick_by(a=0, b=0, c=0): not_implemented()

static func result(a=0, b=0, c=0): not_implemented()

#static func set(a=0, b=0, c=0): not_implemented()

static func set_with(a=0, b=0, c=0): not_implemented()

#static func to_pairs(a=0, b=0, c=0): not_implemented()

#static func to_pairs_in(a=0, b=0, c=0): not_implemented()

static func transform(a=0, b=0, c=0): not_implemented()

static func unset(a=0, b=0, c=0): not_implemented()

static func update(a=0, b=0, c=0): not_implemented()

static func update_with(a=0, b=0, c=0): not_implemented()


static func values(collection): not_implemented()

static func values_in(a=0, b=0, c=0): not_implemented()


