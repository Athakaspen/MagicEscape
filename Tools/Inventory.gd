extends Node

var items = []
var active_item = 'none'

var num_quarters = 0
var num_tickets = 0

func add_quarters(amount:int) -> void:
	num_quarters += amount
	InventoryMenu.update_contents()

func add_tickets(amount:int) -> void:
	num_tickets += amount
	InventoryMenu.update_contents()

func add_item(id:String) -> void:
#	assert(not id in items)
	items.push_back(id)
	InventoryMenu.update_contents()

func remove_item(id:String) -> void:
	assert(id in items)
	items.erase(id)
	if active_item == id:
		active_item = 'none'
	InventoryMenu.update_contents()

func has_item(id:String) -> bool:
	return id in items

func activate_item(id:String) -> void:
	assert(id in items + ['quarter', 'ticket'])
	active_item = id
	InventoryMenu.update_contents()

func deactivate_item() -> void:
	active_item = 'none'
	InventoryMenu.update_contents()
