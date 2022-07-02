extends Node

# this is the runtime config database (dictionary object)
# that contains the current game settings
var DATA = {}
func serialize():
	Global.save_to_file("user://settings.json", DATA)
func unserialize():
	DATA = Global.load_from_file("user://settings.json")

func get_value(setting):
	return DATA[setting]
func set_value(setting, value):
	DATA[setting] = value
