tool
extends Node

# The settings can be accessed directly -- this has the advantage of
# super easy values access and update, HOWEVER we need to make sure
# we remember to call "save_to_disk()" after any setting update!
var json = {

	# (these are all empty at the moment)
	"display": {

	},
	"audio": {

	},
	"controls": {

	},
	"game": {

	}
}

#var has_unsaved_settings = false

###

func get_keybinds_for_action(action):
	var binds_list = []
	if Engine.editor_hint: # for "tool" scripts (in-editor updates)
		var action_setting_path = str("input/" + action)
		if !ProjectSettings.has_setting(action_setting_path):
			return
		var input_event_dat = ProjectSettings.get_setting(action_setting_path)
		if input_event_dat == null || !input_event_dat.has("events"):
			return
		else:
			binds_list = input_event_dat.events
	else:
		binds_list = InputMap.get_action_list(action)
	return binds_list

func find_action_keybind(action, is_joypad):
	# good god..... why must we suffer like this....
	var prev_bind = null
	var prev_keybinds = get_keybinds_for_action(action)
	for kb in prev_keybinds:
		if (kb is InputEventJoypadButton == is_joypad):
			prev_bind = kb
			break
	return prev_bind
func set_keybind_raw_event(action, prev_bind, new_bind):
	# substitute the previous bind with the new one!
	if prev_bind != null:
		InputMap.action_erase_event(action, prev_bind)
	if new_bind != null:
		InputMap.action_add_event(action, new_bind)

	# save to config and refresh settings menu
	Global.settings_menu.reload_from_saved()
	if !(action in json.controls):
		json.controls[action] = {}
	if new_bind is InputEventJoypadButton:
		json.controls[action]["joypad"] = new_bind.button_index
	else:
		json.controls[action]["keyboard"] = new_bind.scancode

	print("New binds: ", json.controls[action])
	save_to_disk()
func set_keybind_from_event(action, new_bind):
	var is_joypad = new_bind is InputEventJoypadButton
	# good god..... why must we suffer like this....
	var prev_bind = find_action_keybind(action, is_joypad)
	if prev_bind == new_bind:
		return

	# ACTUALLY set the event
	set_keybind_raw_event(action, prev_bind, new_bind)

func set_keybind_from_mapping(action, mapping, is_joypad):
	# GOOD GOD....
	var prev_bind = find_action_keybind(action, is_joypad)

	if prev_bind == null && mapping == null:
		return

	var new_bind = null
	if is_joypad:
		if prev_bind.button_index == mapping:
			return
		new_bind = InputEventJoypadButton.new()
		new_bind.set_button_index(mapping)
	else:
		if prev_bind.scancode == mapping:
			return
		new_bind = InputEventKey.new()
		new_bind.set_scancode(mapping)

	# ACTUALLY set the event
	set_keybind_raw_event(action, prev_bind, new_bind)

###

func on_window_size_change():
	# todo
	pass

func _ready():
	get_tree().get_root().connect("size_changed", self, "on_window_size_change")

func save_to_disk():
	IO.save_json(json, "user://config.json")
func load_from_disk():
	var temp = IO.load_json("user://config.json")
	if temp != null:
		json = temp

	for action in json.controls:
		for device in json.controls[action]:
			set_keybind_from_mapping(action, json.controls[action][device], device == "joypad")
