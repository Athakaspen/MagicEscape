extends CanvasLayer

onready var VBox = $VBoxContainer
var ItemPanel = preload("res://Overlays/Menus/ItemPanel.tscn")

var item_data := {
	"quarter": {
		"sprite": preload("res://Sprites/Icons/quarter_icon.png"),
		"tooltip": "Some quarters"
	},
	"ticket": {
		"sprite": preload("res://Sprites/Icons/ticket_icon.png"),
		"tooltip": "Some Tickets"
	},
	"screwdriver": {
		"sprite": preload("res://Sprites/Icons/screwdriver.png"),
		"tooltip": "Screwdriver"
	},
	"shovel": {
		"sprite": preload("res://Sprites/Icons/shovel_icon.png"),
		"tooltip": "Shovel"
	},
	"metal-detector": {
		"sprite": preload("res://Sprites/Icons/metal-detector.png"),
		"tooltip": "Metal Detector"
	},
	"sledgehammer": {
		"sprite": preload("res://Sprites/Icons/sledgehammer.png"),
		"tooltip": "Sledgehammer"
	},
	"key": {
		"sprite": preload("res://Sprites/Icons/key_icon.png"),
		"tooltip": "A key"
	},
	"letter": {
		"sprite": preload("res://Sprites/Icons/letter_icon.png"),
		"tooltip": "Letter"
	},
	"bucket": {
		"sprite": preload("res://Sprites/Icons/bucket_icon.png"),
		"tooltip": "Bucket"
	},
	"water-bucket": {
		"sprite": preload("res://Sprites/Icons/water-bucket_icon.png"),
		"tooltip": "Bucket of Water"
	},
	"sticky-hand": {
		"sprite": preload("res://Sprites/Icons/sticky-hand.png"),
		"tooltip": "Sticky Hand Toy"
	},
	
	"red-disk": {
		"sprite": preload("res://Sprites/Icons/disk-red_icon.png"),
		"tooltip": "A red disk"
	},
	"orange-disk": {
		"sprite": preload("res://Sprites/Icons/disk-orange_icon.png"),
		"tooltip": "An orange disk"
	},
	"yellow-disk": {
		"sprite": preload("res://Sprites/Icons/disk-yellow_icon.png"),
		"tooltip": "A yellow disk"
	},
	"green-disk": {
		"sprite": preload("res://Sprites/Icons/disk-green_icon.png"),
		"tooltip": "A green disk"
	},
	"blue-disk": {
		"sprite": preload("res://Sprites/Icons/disk-blue_icon.png"),
		"tooltip": "A blue disk"
	},
	"purple-disk": {
		"sprite": preload("res://Sprites/Icons/disk-purple_icon.png"),
		"tooltip": "A purple disk"
	},
	"rainbow-disk": {
		"sprite": preload("res://Sprites/Icons/disk-rainbow_icon.png"),
		"tooltip": "A rainbow disk"
	}
}

func _ready():
	update_contents()

func update_contents():
	# clear old contents
	for child in VBox.get_children():
		child.queue_free()
	
	# add quarters
	if Inventory.num_quarters > 0:
		add_quarter_panel(Inventory.num_quarters)
	
	# add tickets
	if Inventory.num_tickets > 0:
		add_ticket_panel(Inventory.num_tickets)
	
	# add normal items
	for item in Inventory.items:
		add_panel(item)

func add_panel(item_id):
	var panel = create_panel(item_id)
	VBox.add_child(panel)

func add_quarter_panel(count:int):
	var panel = create_panel('quarter')
	panel.get_child(2).show() # count
	panel.get_child(2).text = str(count)
	if count == 1:
		panel.set_tooltip("A quarter")
	else:
		panel.set_tooltip("%s quarters" % count)
	VBox.add_child(panel)

func add_ticket_panel(count:int):
	var panel = create_panel('ticket')
	panel.get_child(2).show() # count
	panel.get_child(2).text = str(count)
	if count == 1:
		panel.set_tooltip("A ticket")
	else:
		panel.set_tooltip("%s tickets" % count)
	VBox.add_child(panel)

func create_panel(item_id):
	var panel = ItemPanel.instance()
	# set texture, or backup to id label
	if item_id in item_data.keys():
		panel.get_child(1).texture = item_data[item_id]["sprite"]
		panel.set_tooltip(item_data[item_id]["tooltip"])
	else:
		panel.set_tooltip(item_id)
	# set id
	panel.id = item_id
	# click signal
	panel.connect("clicked", self, "_on_panel_clicked")
	# ACtive coloring
	if Inventory.active_item == item_id:
		panel.modulate = Color.red
	
	return panel

func _on_panel_clicked(id:String) -> void:
	if id != Inventory.active_item:
		Inventory.activate_item(id)
		# extra functionality
		match id:
			'letter':
				ScreenManager.create_overlay("res://Overlays/Letter.tscn")
			'metal-detector':
				# this message will be overwritten when it works
				Notifications.notify("The metal detector didn't find anything here.")
				WorldData.emit_signal("use_metal_detector")
				Inventory.deactivate_item()
	else:
		Inventory.deactivate_item()
