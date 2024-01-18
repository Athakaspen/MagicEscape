extends Node

# Dictionary of all collectables in the world.
# TRUE means it should be visible and avaiable
# FALSE means it's not in the world, probably already collected.
var collectable_dict := {
	"quarter-road": true,
	"quarter-desk": true,
	"quarter-topshelf": true,
	"quarter-garden": true,
	"quarter-arcade": true,
	"quarter-cabinet": true,
	"quarter-safe": true,
	"shovel": true,
	"metal-detector": true,
	"sledgehammer": true,
	"screwdriver": true,
	"bucket": true,
	"sticky-hand": true,
	"closet-disk": true,
	"safe-disk": true,
	"orange-disk": true,
	"green-disk": true,
	"cabinet-disk": true,
	"purple-disk": true,
	"rainbow-disk": true,
	"cake": true
}

# this gets filled with the disks as they're entered into the computer
var saved_disks = []

# Location of the house. Can be "home", "wall", "garden", or "arcade", or a color
var house_location = "wall"

# whether to show the diary on the home screen
var first_open := true
# whether to open the door in west room
var in_intro := true

var easy_traffic : bool
func _ready():
	randomize()
	easy_traffic = randf() < 0.6

# whether we've dug up the hole in the garden yet
var has_dug = false
# same, but for the sledgehammer
var has_dug_sledge = false
# whether we've broken the wall with sledge
var has_broken_wall = false
# whether we've decrypted the rainbow disk
var has_decrypted_disk = false

# whether we've escaped yet
var escaped = false

var game_timer := 0.0
var timer_active := false
func start_timer():
	timer_active = true
func stop_timer():
	timer_active = false

# whether we've cleaned the mat
var is_mat_cleaned = false

# time til next free quarter
var quarter_time = 0
signal spawn_quarter

func _process(delta):
	# game timer
	if timer_active:
		game_timer += delta
	# quarter timer
	if check_item('quarter-arcade') == false:
		quarter_time -= delta
		if quarter_time <= 0:
			collectable_dict['quarter-arcade'] = true
			emit_signal('spawn_quarter')

# number of tickets given to machine
var num_tickets_payed = 0

var test_door_locked = true

# whether the front door of the witch's house is open
#var front_door_open = false

# making sure you look both ways before crossing the street
var looked_left = false
var looked_right = false


var is_trapdoor_locked := true setget set_trapdoor
signal trapdoor_unlocked
func set_trapdoor(value):
	is_trapdoor_locked = value
	# automatic open
	if value == false:
		emit_signal("trapdoor_unlocked")

# warning-ignore:unused_signal
signal bookshelf_organized

# warning-ignore:unused_signal
signal safe_unlocked

# warning-ignore:unused_signal
signal use_metal_detector

# current state of color code
var color_code = ["white", "white", "white"]
var color_code_answer = ['blue', 'orange', 'purple']
var color_code_position := 0 # next color to be input

func input_color(name:String) -> void:
	assert(name in ["red", "orange", "yellow", "green", "blue", "purple"], "invalid color %s" % name)
	# enter color
	color_code[color_code_position] = name
	# reset
	if color_code_position == 0:
		color_code[1] = "white"
		color_code[2] = "white"
	# increment
	color_code_position = (color_code_position + 1 ) % 3
	
	if color_code == color_code_answer:
		house_location = 'home'
		Notifications.notify("Looks like that worked!")
	elif color_code_position == 0:
		Notifications.notify("No reaction...")

func check_item(id:String) -> bool:
	assert(id in collectable_dict.keys(), "id %s not found" % id)
	return collectable_dict[id]

func take_item(id:String) -> void:
	assert(id in collectable_dict.keys(), "id %s not found" % id)
	assert(collectable_dict[id] == true, "id %s not currently true" % id)
	
	collectable_dict[id] = false
