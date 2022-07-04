extends Node

var game_root = null
var level = null
var textbox = null
var settings_menu = null
var config_keypress_dialog = null
var player = null
var health = 10

func process_exit():
	get_tree().quit()

func add_scene(scene_parent, scene_path, node_name):
	var level_node = load(scene_path).instance()
	level_node.name = node_name
	scene_parent.add_child(level_node)
	return level_node

func lose_health(var damage_taken):
	health -= damage_taken
	print(health)
