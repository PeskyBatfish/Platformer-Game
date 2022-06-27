extends KinematicBody2D

# State machine
enum States{AIR = 1, FLOOR, LADDER}
var state = States.AIR

# Variables for movement
var velocity = Vector2(0,0)
var snap_vector = SNAP_DIRECTION * SNAP_LENGTH
var direction = -1
const SPEED = 450
const GRAVITY = 30
const JUMPFORCE = -900
const SNAP_DIRECTION = Vector2.DOWN
const SNAP_LENGTH = 12.0
const FLOOR_NORMAL = Vector2.UP
const FLOOR_MAX_ANGLE = deg2rad(60)

# Variables for bullets
const BULLET = preload("res://Player/Bullet.tscn")
var bullet_strength = 10

func _physics_process(_delta):
	match state:
		States.AIR:
			if is_on_floor():
				state = States.FLOOR
				continue
			$AnimationPlayer.play("Air")
			
			# Basic air movement
			if Input.is_action_pressed("right"):
				velocity.x = lerp(velocity.x, SPEED, 0.1) if velocity.x < SPEED else lerp(velocity.x, SPEED, 0.03)
				$Sprite.flip_h = true
			elif Input.is_action_pressed("left"):
				velocity.x = lerp(velocity.x, -SPEED, 0.1) if velocity.x > -SPEED else lerp(velocity.x, -SPEED, 0.03)
				$Sprite.flip_h = false
			else:
				velocity.x = lerp(velocity.x, 0, 0.2)
				# Remove the excess frames of slowing down
				if !Input.is_action_pressed("right") and !Input.is_action_pressed("left"): 
					if velocity.x < 1 and velocity.x > -1:
						velocity.x = 0
			set_direction()
			move_and_fall()
			fire()
		States.FLOOR:
			if not is_on_floor():
				state = States.AIR

			# Basic movement
			if Input.is_action_pressed("right"):
				velocity.x = lerp(velocity.x, SPEED, 0.1)
				$AnimationPlayer.play("Walk")
				$Sprite.flip_h = true
			elif Input.is_action_pressed("left"):
				velocity.x = lerp(velocity.x, -SPEED, 0.1)
				$AnimationPlayer.play("Walk")
				$Sprite.flip_h = false
			else:
				$AnimationPlayer.play("Idle")
				velocity.x = lerp(velocity.x, 0, 0.2)
				# Remove the excess frames of slowing down
				if !Input.is_action_pressed("right") and !Input.is_action_pressed("left"): 
					if velocity.x < 1 and velocity.x > -1:
						velocity.x = 0
			
			if Input.is_action_just_pressed("jump"):
				velocity.y = JUMPFORCE
				state = States.AIR
			if Input.is_action_pressed("down") and !Input.is_action_pressed("right") and !Input.is_action_pressed("left"):
				$AnimationPlayer.play("Crouch")
			set_direction()
			move_and_fall()
			fire()
		States.LADDER:
			pass

############################
# MOVEMENT PHYSICS FUNCTIONS
############################
# Change the direction of the player sprite and wallchecker raycast
func move_and_fall():
	velocity.y += GRAVITY
	velocity.y = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, true, 32, FLOOR_MAX_ANGLE).y

func set_direction():
	direction = 1 if $Sprite.flip_h else -1
	$Wallchecker.rotation_degrees = 90 * -direction
	$InteractablesChecker.position.x = direction * 16
	$HiddenInteractablesChecker.position.x = direction * 16

# Return a wall collision
func is_near_wall():
	return $Wallchecker.is_colliding() and not $Wallchecker.get_collider().is_in_group("one_way")

func fire():
	if Input.is_action_just_pressed("shoot") and not is_near_wall():
		var b = BULLET.instance()
		if Input.is_action_pressed("down") and not is_on_floor():
			b.horizontal_dir = 0
			b.vertical_dir = 1
			b.position.y = position.y + 16
			b.position.x = position.x
		elif Input.is_action_pressed("up"):
			b.horizontal_dir = 0
			b.vertical_dir = -1
			b.position.y = position.y - 128
			b.position.x = position.x
		else:
			b.horizontal_dir = direction
			b.position.y = position.y - 58
			b.position.x = position.x + (direction * 48)
		b.bullet_strength = bullet_strength
		get_parent().add_child(b)
