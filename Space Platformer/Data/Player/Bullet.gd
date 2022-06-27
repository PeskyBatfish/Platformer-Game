extends KinematicBody2D

var velocity = Vector2()
var bullet_strength = 0
var horizontal_dir = 0
var vertical_dir = 0
var currently_exploding = false
const SPEED = 1000


func _ready():
	velocity.x = SPEED * horizontal_dir
	velocity.y = SPEED * vertical_dir

func _physics_process(_delta):
	if is_on_wall() or is_on_floor() or is_on_ceiling():
		explode()
	if not currently_exploding:
		velocity = move_and_slide(velocity, Vector2.UP)
 
func explode():
	$CollisionShape2D.disabled = true
	$AnimationPlayer.play("Explode")
	currently_exploding = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_AnimatedSprite_animation_finished():
	if currently_exploding:
		queue_free()
