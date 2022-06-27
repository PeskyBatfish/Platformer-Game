extends RigidBody2D

var velocity = Vector2()
var speed = 30
var horizontal_dir = 0
var vertical_dir = 0
var random_movement = rand_range(0,0.1)

func _ready():
	velocity.x = speed * horizontal_dir
	velocity.y = speed * vertical_dir

func _physics_process(_delta):
	horizontal_dir -= random_movement
	velocity.x = speed * horizontal_dir
	set_applied_force(velocity)

func _on_Timer_timeout():
	queue_free()
