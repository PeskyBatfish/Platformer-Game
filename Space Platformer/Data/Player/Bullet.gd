extends KinematicBody2D

var type = 0
var velocity = Vector2()
var bullet_strength = 0
var direction = Vector2()
var currently_exploding = false
const SPEED = 1000


func _ready():
	velocity = SPEED * direction

func _physics_process(_delta):
	if is_on_wall() or is_on_floor() or is_on_ceiling():
		explode()
	if not currently_exploding:
		velocity = move_and_slide(velocity, Vector2.UP)

	if type == 0:
		velocity += Vector2(0, 100)

func explode():
	$CollisionShape2D.disabled = true
	$AnimationPlayer.play("Explode")

	if !currently_exploding && type == 0:
		for x in range(max(0, rand_range(1, 1))):
			Bullets.spawn_bullet(type, position, Vector2(0, -1).rotated(randf() * 2 * PI), bullet_strength)
#			Bullets.spawn_bullet(type, position, Vector2(0, -1), bullet_strength)

	currently_exploding = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_AnimatedSprite_animation_finished():
	if currently_exploding:
		queue_free()
