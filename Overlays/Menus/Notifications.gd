extends CanvasLayer

const DUR = 3.0 # seconds to show message

var time = 0.0
var notifications = []
onready var label = $VBoxContainer/PanelContainer/MarginContainer/Label

func _process(delta):
	if notifications.size() > 0 and time <= 0.0:
		label.text = notifications.pop_front()
		visible = true
		time = DUR
	elif time <= 0.0:
		visible = false
	
	if time > 0.0:
		time -= delta

func notify(text:String, queue:bool = false) -> void:
	if queue: 
		# add message to queue
		notifications.push_back(text)
	else:
		# overwrite queue and show immediately
		notifications = [text]
		time = 0.0

func clear():
	notifications = []
	time = 0.0
