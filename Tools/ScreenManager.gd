extends Node

var overlay_res = preload("res://Overlays/OverlayTemplate.tscn")
var flash_res = preload("res://Overlays/Screenflash.tscn")

func change_screen(path:String) -> void:
	MouseHelper.set_cursor("normal")
	Inventory.deactivate_item()
	Notifications.clear()
# warning-ignore:return_value_discarded
	get_tree().change_scene(path)

func create_overlay(path:String):
	var overlay = overlay_res.instance()
	var content = load(path).instance()
	overlay.add_child(content)
	overlay.move_child(content, 1) # put content between the BG and UI
	add_child(overlay)

func do_screenflash():
	add_child(flash_res.instance())
