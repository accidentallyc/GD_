@tool
extends EditorScript

var _html:FileAccess
var _script:FileAccess
var total_count = 0
var unfinished_count = 0

func _run():
	_script = FileAccess.open("res://addons/gd_/GD_.gd", FileAccess.READ)
	
	var lines = []
	var data = {
		
	}
	
	var line = _script.get_line()
	var index = 0
	var end_of_doc = false
	var func_cat
	var total = 0
	var pending =0
	while not(_script.eof_reached()):
		var should_log = false
		lines.append(line)
		
		var line_anchor = line.substr(0,10)
		if line_anchor == "CATEGORY: ":
			func_cat = line.substr(10).to_lower()
			data[func_cat] = []
		elif line_anchor == "static fun":
			var def = {
				"category": func_cat
			}
			total_count += 1
			
			var splits =  line.substr(12).split("(",true,1)
			var func_name = splits[0]
			var is_pending = splits.size() > 1 and splits[1].contains("not_implemented")
			
			def.name = func_name
			def.is_pending = is_pending
			
			total +=1
			if is_pending:
				pending +=1
				
			if not is_pending:
				var i = index - 1
				var buffer = []
				var has_text = false
				while i >= 0:
					if not lines[i].strip_edges(): 
						def.descp = buffer
						has_text = true
						buffer = []
						break
					
					var tmp = lines[i].substr(2)
					
					match tmp.strip_edges().to_lower():
						"example":
							def.example = buffer
							has_text = true
							buffer = []
						"returns":
							def.returns = buffer[0].split(":")
							has_text = true
							buffer = []
						"arguments":
							var fixed = []
							for b in buffer:
								fixed.append(b.split(":"))
							def.arguments = fixed
							has_text = true
							buffer = []
						"notes":
							def.comparison = buffer
							has_text = true
							buffer = []
						_:
							buffer.push_front(clean(tmp))
					i -= 1
					
				if not has_text: 
					print("Function %s is missing documentation " % func_name)
					
			data[func_cat].append(def)
				
		
		if line == "NON-LODASH FUNCS":
			break
			end_of_doc = true
		
		index += 1
		line = _script.get_line()
	
	# Close GD_Script
	_script.close()
	
	_html = FileAccess.open("./index.html", FileAccess.WRITE)
	
	var keys = GD_.map(data.keys(), GD_.to_lower)
	var final_shape = []
	
	
	for k in keys:
		final_shape.append({
			"category": k,
			"items": data[k]
		})
	
	var template = FileAccess.get_file_as_string("./docs/index.template.html")
	var content = template.replace("{/*%%insert json%%*/}", JSON.stringify(final_shape))
	
	_html.store_string(content)
	_html.close()
	
	
	print("Succesful written to %s %s/%s" % [ _html.get_path(),total-pending,total])

func clean(ln): return ln.replace("		","").strip_edges()
