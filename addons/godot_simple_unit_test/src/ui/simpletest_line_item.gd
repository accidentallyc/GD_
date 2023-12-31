extends VBoxContainer

@onready var statusNode:Label = %Status
@onready var descpNode:Label = %Description
@onready var childContainerNode:Control = %"Children Container"
@onready var rerunButton:Button = %"Rerun Button"

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

func _ready():
	update_element()
	_is_ready = true

func update_element():
	# Update Status
	statusNode.text = status.capitalize()
	match status:
		&"FAIL":
			statusNode.modulate = Color.RED
			statusNode.show()
		&"PASS":
			statusNode.modulate = Color.GREEN
			statusNode.show()
		&"PASS (SOLO)":
			statusNode.modulate = Color.DARK_TURQUOISE
			statusNode.show()
		&"SKIPPED":
			statusNode.modulate = Color.MAGENTA
			statusNode.show()
		_:
			statusNode.hide()
		
	# Description Logic
	var tmp = description
	if statusNode.visible:
		tmp = "  -  " + description
	descpNode.text = tmp
	name = "Description" + tmp

func add_block(block:Control):
	childContainerNode.add_child.call_deferred(block)
	
func clear_blocks():
	if childContainerNode:
		for c in childContainerNode.get_children():
			c.queue_free()
