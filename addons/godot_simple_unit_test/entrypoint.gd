@tool
extends EditorPlugin

func _enter_tree():
	var expected_path = "res://addons/godot_simple_unit_test"
	var dir = DirAccess.open(expected_path)
	if dir:
		print("Simple Test activated.")
	else:
		printerr("Warning, SimpleTest folder should reside at ",expected_path,". This will break a few things")
