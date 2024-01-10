extends CanvasLayer

@export var container:Control

func add_block(block:Control):
	container.add_block.call_deferred(block)
