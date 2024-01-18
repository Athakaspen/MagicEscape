# Clickable Area
extends Area2D
class_name ClickableArea

tool

export(String, "examine", "hand", "forward", "back", "turnaround", "left", "right", "normal", "rotate") var hover_cursor = "examine"
export(bool) var debug = false

signal clicked() # signal when this area has been clicked

func _ready():
	# make shape unique
	if Engine.editor_hint:
		if get_child_count() == 0:
			# add collision shape as child
			var c = CollisionShape2D.new()
			c.shape = RectangleShape2D.new()
			c.shape.extents = Vector2(100,100)
			add_child(c)
			
			# I don't get this part, but it makes the node appear in the tree
			c.set_owner(get_tree().get_edited_scene_root())
			
			# make children unselectable
			set_meta("_edit_group_", true)
			
#		else:
#			$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	
	else:	# in actual game, link signals
# warning-ignore:return_value_discarded
		connect("mouse_entered", self, "_on_mouse_entered")
# warning-ignore:return_value_discarded
		connect("mouse_exited", self, "_on_mouse_exited")
# warning-ignore:return_value_discarded
		connect("input_event", self, "_on_input_event")

func _on_mouse_entered():
	MouseHelper.set_cursor(hover_cursor)

func _on_mouse_exited():
	MouseHelper.set_cursor("normal")

func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("mouseleft")\
	or (event is InputEventScreenTouch and event.is_pressed()):
		emit_signal("clicked")
		if debug:
			print("%s clicked" % name)

