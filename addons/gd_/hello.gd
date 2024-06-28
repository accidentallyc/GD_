@tool
extends EditorPlugin

func _enable_plugin():
    print_rich("For GD_ docs see [url=https://accidentallyc.github.io/GD_/]https://accidentallyc.github.io/GD_/[/url]")

func _enter_tree():
    add_autoload_singleton("GDInternal_ResourceGroup", "./GDInternal_ResourceGroup.tscn")
