extends Node

var textbox = null
var player = null
var health = 10

func process_exit():
	get_tree().quit()

func lose_health(var damage_taken):
	health -= damage_taken
	print(health)
