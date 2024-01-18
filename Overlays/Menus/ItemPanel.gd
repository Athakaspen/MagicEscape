extends PanelContainer

var id := "UNDEFINED"
signal clicked(item_id)


func _on_PanelContainer_mouse_entered():
	MouseHelper.set_cursor('hand')
	$Tooltip.show()

func _on_PanelContainer_mouse_exited():
	MouseHelper.set_cursor('normal')
	$Tooltip.hide()

func _on_Icon_gui_input(event):
	if event.is_action_pressed('mouseleft')\
	or (event is InputEventScreenTouch and event.is_pressed()):
		emit_signal("clicked", id)

func set_tooltip(text:String) -> void:
	$Tooltip/Label.text = text
