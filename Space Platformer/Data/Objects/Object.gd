extends StaticBody2D

export var object_name := ''
export var dialogue_id := ''

signal start_dialogue


func _ready():
	$Sprite.set_visible(false)


func start_talking():
	emit_signal("start_dialogue", dialogue_id)
	pass
#
#
#func activate_arrow():
#	$AnimatedSprite.set_visible(true)
#
#func deactivate_arrow():
#	$AnimatedSprite.set_visible(false)
