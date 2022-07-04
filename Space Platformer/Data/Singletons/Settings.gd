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
func get_single_bind_for_action(action, is_joypad):
	pass

###

func on_window_size_change():
	# todo
	pass

func _ready():
	get_tree().get_root().connect("size_changed", self, "on_window_size_change")

func save_to_disk():
	IO.save_json(json, "user://config.json")
func load_from_disk():
	json = IO.load_json("user://config.json")
