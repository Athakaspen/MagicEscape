extends Node

var cursor_dict = {
	"normal": [load("res://Sprites/Cursors/musimegane.png"), Vector2(10, 10)],
	"examine": [load("res://Sprites/Cursors/musimegane-red.png"), Vector2(10, 10)],
	"forward": [load("res://Sprites/Cursors/forward.png"), Vector2(16,16)],
	"back": [load("res://Sprites/Cursors/back.png"), Vector2(16,16)],
	"left": [load("res://Sprites/Cursors/left.png"), Vector2(16,16)],
	"right": [load("res://Sprites/Cursors/right.png"), Vector2(16,16)],
	"up": [load("res://Sprites/Cursors/up.png"), Vector2(16,16)],
	"down": [load("res://Sprites/Cursors/down.png"), Vector2(16,16)],
	"turnaround": [load("res://Sprites/Cursors/turnaround.png"), Vector2(16,16)],
	"hand": [load("res://Sprites/Cursors/take.png"), Vector2(16,16)],
	"wait": [load("res://Sprites/Cursors/wait.png"), Vector2(16,16)],
	"rotate": [load("res://Sprites/Cursors/rotate.png"), Vector2(16,16)]
}

#var prev = 'normal'

func set_cursor(new_cursor:String, cursor_type:=Input.CURSOR_ARROW) -> void:
	assert(new_cursor in cursor_dict.keys())# + ['prev'])
	
	# special case to revert to previous cursor
#	if new_cursor == 'prev': 
#		new_cursor = prev
	
	var data = cursor_dict[new_cursor]
#	prev = new_cursor
	
	Input.set_custom_mouse_cursor(data[0], cursor_type, data[1])

