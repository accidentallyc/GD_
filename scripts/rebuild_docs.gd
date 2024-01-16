@tool
extends EditorScript

var _md:FileAccess
var _script:FileAccess
var total_count = 0
var unfinished_count = 0

func _run():
	_script = FileAccess.open("res://addons/gd_/GD_.gd", FileAccess.READ)
	_md = FileAccess.open("./api.md", FileAccess.WRITE)
	
	var lines = []
	
	var line = _script.get_line()
	var index = 0
	var end_of_doc = false
	while not(_script.eof_reached()):
		lines.append(line)
		
		if line.substr(0,11) == "static func":
			total_count += 1
			
			var splits =  line.substr(12).split("(",true,1)
			var func_name = splits[0]
			var is_pending = splits.size() > 1 and splits[1].contains("not_implemented")
			var string = "## `%s `\n" % func_name 
			write_ln( "## `%s `" % func_name )
				
			if is_pending:
				write_ln( "> NOT YET IMPLEMENTED" )
				unfinished_count += 1
			else:
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
							buffer.push_front(tmp)
					i -= 1
					
				if descp_buffer:
					write_description_buffer(descp_buffer)
					
				if arguments_buffer:
					write_arguments_buffer(arguments_buffer)
					
				if example_buffer:
					write_example_buffer(example_buffer)
					
				write_ln("\n")
		
		if line == "NON-LODASH FUNCS":
			break
			end_of_doc = true
		
		index += 1
		line = _script.get_line()
	
	
	_script.close()
	_md.close()
	
	print("Succesful written to ./api.md %s/%s" % [total_count - unfinished_count, total_count])
	
func write_description_buffer(buffer: Array):
	for ln in buffer:
		write_ln(ln)

func write_arguments_buffer(buffer: Array):
	write_ln("### Arguments")
	for ln in buffer:
		write_ln(str(" * ",clean(ln)))

func write_example_buffer(buffer:Array):
	write_ln("### Example")
	write_ln("```gdscript")
	for ln in buffer:
		write_ln(clean(ln))
	write_ln("```")

func write_ln(ln):
	_md.store_string(ln + "\n")
func clean(ln): return ln.replace("		","")
