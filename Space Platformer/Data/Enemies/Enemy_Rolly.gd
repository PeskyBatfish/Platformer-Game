extends KinematicBody2D

# Variables for movement
var gravity = 15
var speed = 50
var velocity = Vector2()
export var direction = -1
export var detects_cliffs = true

# Other variables
var damage_colliding = 1
var is_dying = false


func _ready():
	if direction == 1:
		$Sprite.flip_h = true
	$floor_checker.position.x = $floor_hitbox.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs


func _physics_process(delta):
	if is_on_wall() or not $floor_checker.is_colliding() and detects_cliffs and is_on_floor():
		direction *= -1
		$Sprite.flip_h = not $Sprite.flip_h
		$floor_checker.position.x = $floor_hitbox.shape.get_extents().x * direction
	
	velocity.y += gravity	
	velocity.x = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)

func _dying():
	set_collision_layer_bit(4,false)
	set_collision_mask_bit(0,false)
	speed = 0
	$DeathTimer.start()

func _on_DeathTimer_timeout():
	queue_free()


func _on_Hitbox_area_entered(area):
	if area.get_collision_layer() == 8:
		queue_free()

func _on_Hitbox_body_entered(body):
	if not is_dying:
		if body.get_collision_layer() == 1:
			body.knockback(position.x, damage_colliding)
		elif body.get_collision_layer() == 8:
			body.explode()
			is_dying = true
			_dying()
