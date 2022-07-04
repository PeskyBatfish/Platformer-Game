extends Control
class_name Menu

export(String) var menu_id = ""
export(PoolStringArray) var parent_menus = [] # used for the keybind input check and input bleed prevention!
export(String) var default_keybind = ""
export(bool) var can_be_closed = false

func _ready():
	UI.menu_node_register(self, menu_id)
	visible = false
