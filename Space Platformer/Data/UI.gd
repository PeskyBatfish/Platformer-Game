extends Node

enum MENUS {
	main_menu,
	pause_menu,

	new_game,
	save_game,
	load_game,
	quit_to_main_menu_confirmation,

	settings,

	credits,
	about,
	splash_screen,

	ingame,
	inventory,
	crafting,
	gestures,

	MAX_MENU_ITEM_ID
}

var MENU_RECORDS = {} # this gets filled during runtime

var current_menu_id = null

func menu_id_is_valid(menu_id):
	if menu_id == null:
		return false
	# I don't know how to check if variable is a valid enum value...
	# we'll assume it is valid.. for now!
	if !(menu_id < MENUS.MAX_MENU_ITEM_ID):
		return false
	return true
func menu_node_register(node, menu_id):
	# check that the both the node and the menu id are valid!
	if node == null || !menu_id_is_valid(menu_id):
		return false
	# record the pair
	MENU_RECORDS[menu_id] = node
	return true

###

func _close_menu(menu_id):
	if MENU_RECORDS.has(menu_id):
		MENU_RECORDS[menu_id].visible = false
func _open_menu(menu_id):
	if MENU_RECORDS.has(menu_id):
		MENU_RECORDS[menu_id].visible = true

func set_menu(menu_id):
	if !menu_id_is_valid(menu_id):
		return false
	_close_menu(current_menu_id)
	_open_menu(menu_id)
	current_menu_id = menu_id

	# for debugging -- set back to "ingame" if there's no valid menu node!
	if !MENU_RECORDS.has(menu_id) && menu_id != MENUS.ingame:
		current_menu_id = MENUS.ingame

	return true
