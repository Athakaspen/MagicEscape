extends Node2D


func _on_WinZone_area_shape_entered(_area_rid, _area, _area_shape_index, _local_shape_index):
#	if area.is_winning_piece:
		Notifications.notify("It looks like the number '724' is written on the back of this piece.")
		$"GoldPiece/724".show()
#	Notifications.notify("You win! It took you %s seconds." % str(time))

var time = 0
func _process(delta):
	time += delta

func _on_Back_clicked():
	ScreenManager.change_screen("res://Screens/Sidetable.tscn")

