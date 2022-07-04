tool
extends Label

export(float, 10.0, 3000.0) var speed = 100.0
var dir = Vector2(1, 1)

func _process(delta):
#	print(rect_position)
	rect_position += dir * delta * speed
	if rect_position.x + rect_size.x >= 450:
		rect_position.x = 450 - rect_size.x
		dir.x = -dir.x
	if rect_position.x <= 0:
		rect_position.x = 0
		dir.x = -dir.x

	if rect_position.y + rect_size.y >= 270:
		rect_position.y = 270 - rect_size.y
		dir.y = -dir.y
	if rect_position.y <= 0:
		rect_position.y = 0
		dir.y = -dir.y
