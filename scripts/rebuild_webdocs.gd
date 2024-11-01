@tool
extends EditorScript

var total = 0
var nondash = 0
var pending =0
var data:Dictionary

var gd_files = {
    "Array" : "GD_array.gd",
    "Collection" : "GD_collection.gd",
    "Object" : "GD_object.gd",
    "Function" : "GD_function.gd",
    "Math" : "GD_math.gd",
    "Number" : "GD_number.gd",
    "Util" : "GD_util.gd", 
    "Date" : "GD_date.gd",
    "String" : "GD_string.gd",
    "Lang" : "GD_lang.gd",
}


func _run():
    data = {}
    total = 0
    nondash = 0
    pending =0
    for f in gd_files:
        data[f] = extract_func_defs(f, gd_files[f])
        
    var html := FileAccess.open("./index.html", FileAccess.WRITE)
  
    var keys = data.keys()
    keys.sort()
    var final_shape = []
    
    for k in keys:
        final_shape.append({
        "category": k,
        "items": data[k]
        })
    
    var template = FileAccess.get_file_as_string("./docs/index.template.html")
    var content = template.replace("{/*%%insert json%%*/}", JSON.stringify(final_shape))
    
    html.store_string(content)
    html.close()
    
    print("Succesful written to %s %s/%s" % [ html.get_path(),total-pending-nondash,total-nondash])

func extract_func_defs(category, fileName):
    var script := FileAccess.open("res://addons/gd_/src/"+fileName, FileAccess.READ)
    
    var lines = []
    var line = script.get_line()
    var index = 0

    var defs = []
    while not(script.eof_reached()):
        lines.append(line)
        
        var line_anchor = line.substr(0,10)
        if line_anchor == "static fun":
            var def = { "category": category }
        
            var splits =  line.substr(12).split("(",true,1)
            var func_name = splits[0]
            var is_pending = splits.size() > 1 and splits[1].contains("not_implemented")
            
            def.name = func_name
            def.equivalent = func_name.to_camel_case()
            def.is_pending = is_pending
            
            total +=1
            if is_pending:
                    pending +=1
                    
            if not is_pending:
                var i = index - 1
                var buffer = []
                var has_text = false
                var curr_section = null
                while i >= 0:
                    if not lines[i].strip_edges(): 
                        buffer.reverse()
                        def.descp = buffer
                        has_text = true
                        buffer = []
                        break
                    
                    var tmp = lines[i].substr(2)
                    
                    match tmp.strip_edges().to_lower():
                        "example":
                            buffer.reverse() # faster to reverse than pushfront
                            
                            def.example = buffer.map(func(b): return b.trim_prefix("     "))
                            has_text = true
                            buffer = [] # force reset buffer
                            curr_section = "example"
                        "returns":
                            buffer.reverse() # faster to reverse than pushfront
                            
                            def.returns = buffer[0].split(":")
                            has_text = true
                            buffer = [] # force reset buffer
                            curr_section = "returns"
                        "arguments":
                            buffer.reverse() # faster to reverse than pushfront
                            
                            var fixed = []
                            for b in buffer:
                                var splat = b.split(":")
                                fixed.append([clean(splat[0]),clean(splat[1])])
                            def.arguments = fixed
                            has_text = true
                            buffer = [] # force reset buffer
                            curr_section = "arguments"
                        "notes":
                            buffer.reverse() # faster to reverse than pushfront
                            
                            def.notes = buffer
                            has_text = true
                            buffer = [] # force reset buffer
                            curr_section = "notes"
                        "lodash equivalent":
                            buffer.reverse() # faster to reverse than pushfront
                            
                            var tmp1 =  buffer[0].to_lower().strip_edges()
                            if tmp1 == "none":
                                    nondash += 1
                                    def.equivalent = false
                            else: 
                                    def.equivalent  = tmp1
                            buffer = [] # force reset buffer
                        _:
                            buffer.append(tmp)
                    i -= 1
                
                if not has_text: 
                    print("Function %s is missing documentation " % func_name)
                
            defs.append(def)

    
        index += 1
        line = script.get_line()
  
    # Close GD_Script
    script.close()
    
    return defs
  

func clean(ln): return ln.replace("		","").strip_edges()
