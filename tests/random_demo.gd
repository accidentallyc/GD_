extends SimpleTest

func it_can_transform_data():
	
	# Quick and dirty
	var monsters = []
	monsters.append({ "loot": {"name": "Knife" }})
	monsters.append({ "loot": {"name": "Wand" }})
	monsters.append({ "loot": {"name": "Bow" }})
	
	print(
		GD_.map(monsters, "loot:name")
	)
	# => prints ["Knife","Bow","Wand"]
	
	
	# Unified logic
	
	print( GD_.size("500") )
	# prints 3
	print( GD_.size([1,2,3]) )
	# prints 3
	print( GD_.size({"a":1,"b":2,"c":3}) )
	# prints 3
	
	# Iterators!
	var players = [
		"BaRnEy",
		"PEBBles",
		"john"
	]
	
	GD_.map(players, GD_.to_lower)
	# => Returns ['barney','pebbles','john']
	
