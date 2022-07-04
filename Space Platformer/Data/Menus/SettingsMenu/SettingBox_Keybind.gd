tool
extends ColorRect

export(String) var keybind_label = "UI Left:" setget set_label
export(String) var keybind_action = "ui_left" setget set_action

# setget functions
func set_label(value):
	keybind_label = value
	$Label.text = value
func set_action(value):
	keybind_action = value
	reload_from_saved()

func reload_from_saved():
	$Keybinds/Keyboard/Field.set_action(keybind_action)
	$Keybinds/Joypad/Field.set_action(keybind_action)
