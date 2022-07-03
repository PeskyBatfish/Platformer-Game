extends Node

# these are the full level identifiers
var campaign = -1
var mission = -1
var stage = -1

# scores, play time, etc.
var mission_time = -1
var total_play_time = -1
var score = 0

###

func unload_level():
	if Global.level != null:
		Global.level.free()
	var level_node = Global.game_root.get_node("Level")
	if level_node != null:
		level_node.free()

	# set global level node pointer to null
	Global.level = null

func load_level(level_name, params = null):
	unload_level() # always unload current level first!

	var scene_path = str("res://Levels/", level_name, ".tscn")
	var level_node = load(scene_path).instance()
	level_node.name = "Level"
	Global.game_root.add_child(level_node)
	Global.level = level_node

	# extra params for level continuation/config/etc.
	if params != null:
		pass

	# automatically set state to "ingame" by default
	UI.set_menu(UI.MENUS.ingame)

func load_game(filename):
	pass
func save_game(filename):
	pass

func close_game():
	pass
