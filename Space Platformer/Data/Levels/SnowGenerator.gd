extends Node2D

const SNOWFLAKE = preload("res://Background/Snowflake.tscn")
var wind_strength = 40
var wind_direction = -1
var generation_distance = 3000
var rng = RandomNumberGenerator.new()
var snow_frequency = 0.05

func _ready():
	$Timer.wait_time = snow_frequency
	$Timer.start()

func _on_Timer_timeout():
	var s = SNOWFLAKE.instance()
	var rando = rand_range(0,1)
	rng.randomize()
	var randFrame = rng.randi_range(0,3)
	s.get_node("Sprite").frame = randFrame
	s.horizontal_dir = wind_direction * deg2rad(90)
	s.vertical_dir = 1
	s.speed = wind_strength * (rando + 1)
	s.position.y = 1
	s.position.x = rando * generation_distance
	add_child(s)

