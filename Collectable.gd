# Clickable Area
extends Area2D
class_name Collectable

tool

export(String, "examine", "hand", "forward", "back", "turnaround", "left", "right", "normal", "rotate") var hover_cursor = "hand"
export(bool) var debug = false

# Item ID
export var id := "UNDEFINED"

signal clicked(emitter) # signal when this area has been clicked

func _ready():
	# make shape unique
	if Engine.editor_hint:
		if get_child_count() == 0:
			
			# sprite
			var s = Sprite.new()
			s.texture = load("res://icon.png")
			add_child(s)
			# I don't get this part, but it makes the node appear in the tree
			s.set_owner(get_tree().get_edited_scene_root())
			
			# add collision shape as child
			var c = CollisionShape2D.new()
			c.shape = RectangleShape2D.new()
			c.shape.extents = Vector2(32,32)
			add_child(c)
			# I don't get this part, but it makes the node appear in the tree
			c.set_owner(get_tree().get_edited_scene_root())

			# make children unselectable
			set_meta("_edit_group_", true)
			
#		else:
#			$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	
	# not editor
	else:
		# Check if we should exist
		if WorldData.check_item(id) == false:
			self.queue_free()
		
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
		emit_signal("clicked", self)
		if debug:
			print("%s clicked" % name)

