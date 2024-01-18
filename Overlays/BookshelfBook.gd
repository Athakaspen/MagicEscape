extends TextureButton


var is_selected = false

func _ready():
	get_parent().call_deferred("move_child", self, randi() % get_parent().get_child_count())

func _process(_delta):
	if is_selected:
		
		if get_global_mouse_position().x < rect_global_position.x \
		and self.get_index() > 0 \
		and get_global_mouse_position().x < rect_global_position.x - (get_parent().get_child(get_index()-1).rect_size.x-rect_size.x):
			# shift left
			get_parent().move_child(self, self.get_index() - 1)
		
		elif get_global_mouse_position().x > rect_global_position.x + rect_size.x \
		and self.get_index() < get_parent().get_child_count()-1 \
		and get_global_mouse_position().x > rect_global_position.x + rect_size.x + (get_parent().get_child(get_index()+1).rect_size.x-rect_size.x):
			# shift right
			get_parent().move_child(self, self.get_index() + 1)

func _on_button_down():
	is_selected = true

func _on_button_up():
	is_selected = false
	$"../..".check_success()
