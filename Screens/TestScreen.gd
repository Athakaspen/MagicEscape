extends Node2D

#func _ready():
#	add_child(load("res://Overlays/Letter.tscn").instance())

func _on_Door_clicked():
	if !WorldData.test_door_locked:
		# enter
		ScreenManager.change_screen("res://Screens/TestScreenInside.tscn")
	elif Inventory.active_item == "key":
		# use key
		WorldData.test_door_locked = false
		Inventory.remove_item('key')
		# unlock effect
		Helpers.play_sound(Helpers.SFX_boop)
		Helpers.disable_input(0.4)
		yield(get_tree().create_timer(0.4), 'timeout')
		# enter
		ScreenManager.change_screen("res://Screens/TestScreenInside.tscn")
	else:
		Notifications.notify("It's locked.")


func _on_ClickableArea_clicked():
	if Inventory.active_item == 'shovel':
		Inventory.add_quarters(100)
	else:
		Notifications.notify("I need a shovel to dig here")
