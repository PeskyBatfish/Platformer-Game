extends Control
class_name Menu

export(UI.MENUS) var menu_id = UI.MENUS.MAX_MENU_ITEM_ID
export(UI.MENUS) var parent_menu = UI.MENUS.MAX_MENU_ITEM_ID # used for the keybind input check!
export(String) var default_keybind = ""
export(bool) var can_be_closed = false

func _ready():
	UI.menu_node_register(self, menu_id)
	visible = false
