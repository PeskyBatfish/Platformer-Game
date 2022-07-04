extends Node

var default_backdrop = null

var MENU_RECORDS = {} # this gets filled during runtime

var current_menu_id = null
var prev_menus_stack = [] # this starts empty. it gets filled with the PREVIOUS menu upon opening a new one!

func menu_id_is_valid(menu_id):
	if menu_id == null:
		return false
	# I don't know how to check if variable is a valid enum value...
	# we'll assume it is valid.. for now!
	if (menu_id == ""):
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

# Internal methods
func _close_menu(menu_id):
	current_menu_id = null # temporarily set this to null to avoid input bleeding
	if MENU_RECORDS.has(menu_id):
		MENU_RECORDS[menu_id].visible = false
func _open_menu(menu_id):
	if MENU_RECORDS.has(menu_id):
		MENU_RECORDS[menu_id].visible = true

# Boilerplate
func set_menu(menu_id, push_previous = true, close_previous = true):
	if !menu_id_is_valid(menu_id):
		return false
	if !MENU_RECORDS.has(menu_id) && menu_id != "ingame":
		return false

	if menu_id != "ingame" && menu_id != "main_menu":
		var menu_node = MENU_RECORDS[menu_id]

		if current_menu_id == null:
			return
		if !(current_menu_id in menu_node.parent_menus) && !(menu_id in MENU_RECORDS[current_menu_id].parent_menus):
			return

	# push previous menu on the stack and close it
	if push_previous:
		prev_menus_stack.push_back(current_menu_id)
	if close_previous:
		_close_menu(current_menu_id)

	# open the new menu and set the current menu ID
	_open_menu(menu_id)
	current_menu_id = menu_id

	# special case: empty stack if we're back to the main menu
	# (this is to prevent stack bleeding)
	if current_menu_id == "main_menu":
		prev_menus_stack = []

	print(prev_menus_stack)
	return true
func pop_menu():
	# go back to the last menu saved in the stack (usually the parent menu)
	var prev_menus_count = prev_menus_stack.size()
	if prev_menus_count > 0:
		set_menu(prev_menus_stack[prev_menus_count - 1], false)
		prev_menus_stack.pop_back()
		print(prev_menus_stack)
		return true
	else:
		return false

# Main UI input loop!
func _input(event):

	# go through all the registered menus...
	for menu_id in MENU_RECORDS:
		var menu_node = MENU_RECORDS[menu_id]

		# if there's a keybind for this menu...
		if menu_node.default_keybind in InputMap.get_actions() && Input.is_action_just_pressed(menu_node.default_keybind):
			# ...open this menu if we're inside the parent menu
			if current_menu_id in menu_node.parent_menus:
				set_menu(menu_id)
				return
			# ...close this menu if we're inside the current menu
			elif current_menu_id == menu_id:
				pop_menu()
				return
		# if enabled, close the menu and go back to the previous UI/menu on the stack
		elif current_menu_id == menu_id && menu_node.can_be_closed && Input.is_action_just_pressed("ui_cancel"):
			pop_menu()
			return
