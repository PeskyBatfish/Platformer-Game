extends Control
class_name Menu

export(UI.MENUS) var menu_id
export(UI.MENUS) var parent_menu
export(String) var default_keybind = ""

###

func _input(event):

	# if there's a keybind for this menu...
	if default_keybind in InputMap.get_actions() && Input.is_action_just_pressed(default_keybind):
		# ...open this menu if we're inside the parent menu
		if UI.current_menu_id == parent_menu:
			UI.set_menu(menu_id)
			return
		# ...close this menu if we're inside the current menu
		elif UI.current_menu_id == menu_id:
			UI.set_menu(parent_menu)
			return

func _ready():
	UI.menu_node_register(self, menu_id)
	visible = false
