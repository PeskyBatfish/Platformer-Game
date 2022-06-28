extends Control

export(UI.MENUS) var menu_id
export(UI.MENUS) var parent_menu
export(String) var default_keybind = ""

###

func _input(event):

	# if there's a keybind for this menu...
	# ...open this menu if we're inside the parent menu
	if UI.current_menu_id == parent_menu && Input.is_action_just_pressed(default_keybind):
		UI.set_menu(menu_id)
		return
	# ...close this menu if we're inside the current menu
	if UI.current_menu_id == menu_id && Input.is_action_just_pressed(default_keybind):
		UI.set_menu(parent_menu)
		return

func _ready():
	UI.menu_node_register(self, menu_id)
	visible = false
