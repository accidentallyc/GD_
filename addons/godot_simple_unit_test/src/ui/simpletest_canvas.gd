extends CanvasLayer

@export var container:Container

func add_block(block:Control):
	container.add_child.call_deferred(block)
