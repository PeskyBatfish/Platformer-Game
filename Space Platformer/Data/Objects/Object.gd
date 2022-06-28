extends Area2D

export var object_type := ''
export var dialogue_id := ''


func _ready():
	$Sprite.set_visible(false)

func start_speech():
	Global.textbox.start_dialogue(dialogue_id)
	pass

#
#
#func activate_arrow():
#	$AnimatedSprite.set_visible(true)
#
#func deactivate_arrow():
#	$AnimatedSprite.set_visible(false)
