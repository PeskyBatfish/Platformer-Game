tool
extends Button

export(bool) var is_joypad = false

var action = ""

var keybind_backup = null
var keybind = null

func refresh_label():
	if keybind == null:
		text = ""
	else:
		if is_joypad:
			text = Input.get_joy_button_string(keybind.button_index)
		else:
			text = keybind.as_text()
func set_bind(bind):
	keybind = bind
	refresh_label()

# visual flavor
func set_color_conflicting():
	self["custom_colors/font_color"] = Color(1,0,0,1)
func set_color_unsaved():
	self["custom_colors/font_color"] = Color(1,1,0,1)
func set_color_saved():
	self["custom_colors/font_color"] = Color(1,1,1,1)

func _refresh_action():
	# first, erase labels
	text = ""
	set_color_saved()

	# get current keybinds for this input action
	var binds_list = Settings.get_keybinds_for_action(action)
	if binds_list == null:
		return

	# can only do one keyboard bind and one joypad bind (for now)
	var found_one = false

	# iterate through the found keybinds
	for bind in binds_list:
		if (bind is InputEventJoypadButton) == is_joypad:
			# found a valid bind for this field!
			set_bind(bind)
			return # can only do one keyboard bind and one joypad bind (for now)
func set_action(value):
	action = value
	_refresh_action()

func _on_Field_pressed():
	Global.config_keypress_dialog.action = action
	Global.config_keypress_dialog.get_node("Backdrop/KeyText").text = text
	UI.set_menu("wait_for_keypress", true, false)
