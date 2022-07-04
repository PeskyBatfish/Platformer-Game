extends Node


const BULLET = preload("res://Player/Bullet.tscn")

func spawn_bullet(type, pos, dir, strength):
	var b = BULLET.instance()
	b.direction = dir
	b.position = pos
	b.type = type # "type" is todo
	b.bullet_strength = strength
	get_parent().add_child(b)
