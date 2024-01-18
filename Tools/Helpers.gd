extends Node

var SFX_res = preload("res://Tools/SFX.tscn")

var SFX_boop = preload("res://SFX/boop.wav")
var SFX_ding = preload("res://SFX/ding1.wav")
var SFX_powerup = preload("res://SFX/powerup.wav")

# changed when you die
var respawn_scene = "res://Screens/MyHouseInside.tscn"

var RED = Color("ed1c24")
var ORANGE = Color("ff7f27")
var YELLOW = Color("fff200")
var GREEN = Color("22b14c")
var BLUE = Color("00a2e8")
var PURPLE = Color("a349a4")

func get_color_from_name(name:String)->Color:
	match name:
		"red":
			return RED
		"orange":
			return ORANGE
		"yellow":
			return YELLOW
		"green":
			return GREEN
		"blue":
			return BLUE
		"purple":
			return PURPLE
		"white":
			return Color.white
		_:
			print("Color error: no color %s" % name)
			return Color.black

func _input(event):
	if event.is_action_pressed('fullscreen'):
		OS.window_fullscreen = !OS.window_fullscreen

func remove_world_item(item):
	WorldData.take_item(item.id)
	item.queue_free()
	play_sound(SFX_ding)
	MouseHelper.set_cursor('normal')

# timer for reactivating input after delay
var reactivateInputTimer : Timer
func _ready():
	reactivateInputTimer = Timer.new()
	reactivateInputTimer.one_shot = true
	add_child(reactivateInputTimer)

func disable_input(dur:float) -> void:
	# start
	get_tree().get_root().gui_disable_input = true
	MouseHelper.set_cursor('wait')
	# wait
	reactivateInputTimer.start(dur)
	yield(reactivateInputTimer, 'timeout')
	# reset
	get_tree().get_root().gui_disable_input = false
	MouseHelper.set_cursor('normal')

func enable_input() -> void:
	# clear timer
	reactivateInputTimer.stop()
	# reset
	get_tree().get_root().gui_disable_input = false
	MouseHelper.set_cursor('normal')

func play_sound(stream:AudioStream, position:Vector2=Vector2(860,540), volume:float=0.0):
	pass # nah
#	var sfx = SFX_res.instance()
#	sfx.position = position
#	sfx.stream = stream
#	sfx.volume_db = volume
#	call_deferred("add_child", sfx)
