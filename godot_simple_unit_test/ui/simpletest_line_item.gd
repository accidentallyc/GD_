extends VBoxContainer

@onready var statusNode:Label = %Status
@onready var descpNode:Label = %Description
@onready var childContainerNode:Control = %"Children Container"
@onready var rerunButton:Button = %"Rerun Button"
@onready var collapse_toggle:Button = %"Collapse Toggle"

var _runner:SimpleTest_Runner

var status = &"":
    get:
        return status
    set(v):
        status = v
        if _is_ready:
            update_element()
            
var description = &"":
    get:
        return description
    set(v):
        description = v
        if _is_ready:
            update_element()

var _is_ready = false
var parent_ln_item
var case
const collapse_txt = &" ➖ "	
const uncollapse_txt = &" ➕ "	

func _ready():
    collapse_toggle.text = collapse_txt
    update_element()
    _is_ready = true
    
    
func set_runner(runner):
    _runner = runner
    _runner.on_toggle_show_passed_tests.connect(update_element)
    

func update_element():
    # Update Status
    statusNode.text = status.capitalize()
    var HAS_PASSED = status.contains(&"PASS")
    match status:
        &"FAIL":
            statusNode.modulate = Color.RED
            statusNode.show()
            HAS_PASSED = false
        &"PASS":
            statusNode.modulate = Color.GREEN
            statusNode.show()
            HAS_PASSED = true
        &"PASS (SOLO)":
            statusNode.modulate = Color.DARK_TURQUOISE
            statusNode.show()
            HAS_PASSED = true
        &"SKIPPED":
            statusNode.modulate = Color.MAGENTA
            statusNode.show()
            HAS_PASSED = true
        _:
            HAS_PASSED = false
            statusNode.hide()
        
    # Visibility logic
    if HAS_PASSED and _runner._should_show_passed_tests or HAS_PASSED == false:
        self.show()
    else:
        self.hide()
        
    # Description Logic
    var tmp = description
    if statusNode.visible:
        tmp = "  -  " + description
    descpNode.text = tmp
    name = "Description" + tmp

func add_block(block:Control):
    childContainerNode.add_child.call_deferred(block)
    # originally hidden, but adding 1 child means you can collapse it
    collapse_toggle.show() 
    
func clear_blocks():
    if childContainerNode:
        for c in childContainerNode.get_children():
            c.queue_free()
            
    # no children means cant collapse
    collapse_toggle.hide()
    
    
func set_collapse(is_collapse:bool):
    if is_collapse:
        childContainerNode.hide()
        collapse_toggle.text = uncollapse_txt
        return
    childContainerNode.show()
    collapse_toggle.text = collapse_txt
        

func toggle_collapse(force_collapse = null):
    set_collapse(childContainerNode.visible)
