extends Area2D

export(String, "horizontal", "vertical") var direction = "horizontal"

#var check_buffer := 10.0
const MOVE_INCREMENT := 2.0
const RAYCAST_SEPARATION := 46.0
#const MAX_SPEED := 42

var is_hovered := false
var is_grabbed := false

# Called when the node enters the scene tree for the first time.
func _ready():
	var extents = $CollisionShape2D.shape.extents
	var dist
	var dir
	var start1
	var start2
	if direction == "horizontal":
		dist = extents.x + MOVE_INCREMENT
		dir = Vector2.RIGHT
		start1 = Vector2(0, RAYCAST_SEPARATION)
		start2 = Vector2(0, -RAYCAST_SEPARATION)
	else:
		dist = extents.y + MOVE_INCREMENT
		dir = Vector2.DOWN
		start1 = Vector2(RAYCAST_SEPARATION, 0)
		start2 = Vector2(-RAYCAST_SEPARATION, 0)
	
	var RaycastPos1 = RayCast2D.new()
	RaycastPos1.name = "RayCastPos1"
	RaycastPos1.position = start1
	RaycastPos1.cast_to =   dist * dir
	RaycastPos1.collide_with_areas = true
	add_child(RaycastPos1)
	var RaycastPos2 = RayCast2D.new()
	RaycastPos2.name = "RayCastPos2"
	RaycastPos2.position = start2
	RaycastPos2.cast_to =   dist * dir
	RaycastPos2.collide_with_areas = true
	add_child(RaycastPos2)
	var RaycastNeg1 = RayCast2D.new()
	RaycastNeg1.name = "RayCastNeg1"
	RaycastNeg1.position = start1
	RaycastNeg1.cast_to = - dist * dir
	RaycastNeg1.collide_with_areas = true
	add_child(RaycastNeg1)
	var RaycastNeg2 = RayCast2D.new()
	RaycastNeg2.name = "RayCastNeg2"
	RaycastNeg2.position = start2
	RaycastNeg2.cast_to = - dist * dir
	RaycastNeg2.collide_with_areas = true
	add_child(RaycastNeg2)


func _input(event):
	# set grabbed bool
	if is_hovered and event is InputEventMouseButton:
		if event.is_action_pressed("mouseleft"):
			is_grabbed = true
	if is_grabbed and event is InputEventMouseButton:
		if event.is_action_released("mouseleft"):
			is_grabbed = false
	
	# touch release
	if event is InputEventScreenTouch and !event.pressed:
		is_grabbed = false
	
	# movement
	if is_grabbed and event is InputEventMouseMotion:
		var movement : Vector2 = event.relative
		var is_positive
		if direction == "horizontal": 
			movement.y = 0
			is_positive = sign(movement.x) == 1
		else: 
			movement.x = 0
			is_positive = sign(movement.y) == 1
		
#		if movement.length() > MAX_SPEED:
#			movement = movement.normalized() * MAX_SPEED
		var move_length = movement.length()
		
		var raycast1:RayCast2D
		var raycast2:RayCast2D
		if is_positive: 
			raycast1 = $RayCastPos1
			raycast2 = $RayCastPos2
		else: 
			raycast1 = $RayCastNeg1
			raycast2 = $RayCastNeg2
		
		while move_length > MOVE_INCREMENT:
			raycast1.force_raycast_update()
			raycast2.force_raycast_update()
			if !raycast1.is_colliding() and !raycast2.is_colliding():
				position += movement.normalized() * MOVE_INCREMENT
				move_length -= MOVE_INCREMENT
			else:
				break
		
		# final bit of movement
		raycast1.force_raycast_update()
		raycast2.force_raycast_update()
		if !raycast1.is_colliding() and !raycast2.is_colliding():
			position += movement.normalized() * move_length


func _on_Piece_mouse_entered():
	is_hovered = true
	MouseHelper.set_cursor("hand")


func _on_Piece_mouse_exited():
	is_hovered = false
	MouseHelper.set_cursor("normal")


func _on_Piece_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.pressed:
			is_grabbed = true
#			Notifications.notify('touched')
		else:
			is_grabbed = false
#			Notifications.notify('untouched')
