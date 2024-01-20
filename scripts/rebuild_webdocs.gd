@tool
extends EditorScript

var _html:FileAccess
var _script:FileAccess
var total_count = 0
var unfinished_count = 0

func _run():
	_script = FileAccess.open("res://addons/gd_/GD_.gd", FileAccess.READ)
	
	
	var lines = []
	var data = []
	
	var line = _script.get_line()
	var index = 0
	var end_of_doc = false
	while not(_script.eof_reached()):
		lines.append(line)
		
		if line.substr(0,11) == "static func":
			var def = {}
			total_count += 1
			
			var splits =  line.substr(12).split("(",true,1)
			var func_name = splits[0]
			var is_pending = splits.size() > 1 and splits[1].contains("not_implemented")
			
			def.name = func_name
			def.is_pending = is_pending
				
			if not is_pending:
				var i = index - 1
				var buffer = []
				var example_buffer
				var returns_buffer
				var arguments_buffer
				var descp_buffer
				while i >= 0:
					if not lines[i].strip_edges(): 
						descp_buffer = buffer
						buffer = []
						break
					
					var tmp = lines[i].substr(2)
					
					match tmp.strip_edges().to_lower():
						"example":
							example_buffer = buffer
							buffer = []
						"returns":
							returns_buffer = buffer
							buffer = []
						"arguments":
							arguments_buffer = buffer
							buffer = []
						_:
							#print("PUSHING ",tmp)
							buffer.push_front(clean(tmp))
					i -= 1
					
				var has_text = false
				if descp_buffer:
					def.descp = descp_buffer
					has_text = true
					
				if arguments_buffer:
					var fixed = []
					for b in arguments_buffer:
						fixed.append(b.split(":"))
					def.arguments = fixed
					has_text = true
					
				if example_buffer:
					def.example = example_buffer
					has_text = true
					
				if returns_buffer:
					def.returns = returns_buffer[0].split(":")
					has_text = true
					
				if !has_text: 
					print("Function %s is missing documentation " % func_name)
					
			data.append(def)
				
		
		if line == "NON-LODASH FUNCS":
			break
			end_of_doc = true
		
		index += 1
		line = _script.get_line()
	
	# Close GD_Script
	_script.close()
	
	_html = FileAccess.open("./index.html", FileAccess.WRITE)
	var template = FileAccess.get_file_as_string("./docs/index.template.html")
	var content = template.replace("{/*%%insert json%%*/}", JSON.stringify(data))
	
	_html.store_string(content)
	_html.close()
	
	
	print("Succesful written to %s" % _html.get_path())

func clean(ln): return ln.replace("		","").strip_edges()
