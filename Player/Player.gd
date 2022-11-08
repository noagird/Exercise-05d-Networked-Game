extends KinematicBody

onready var camera = $Pivot/Camera

var speed = 5
var gravity = -8.0
var direction = Vector3()
var mouse_sensitivity = 0.002
var mouse_range = 1.2
var velocity = Vector2.ZERO

func _ready():
	camera.current = true

func _physics_process(_delta):
	velocity = get_input()*speed
	velocity.y += gravity
	if is_on_floor():
		velocity.y = 0
	if velocity != Vector3.ZERO:
		velocity = move_and_slide(velocity, Vector3.UP)
		
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)
		rpc_unreliable("_set_rotation", rotation.y)

func die():
	queue_free()
	rpc_unreliable("_die")

func get_input():
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		input_dir += -camera.global_transform.basis.z
		rpc_unreliable("_set_position", global_transform.origin)
	if Input.is_action_pressed("back"):
		input_dir += camera.global_transform.basis.z
		rpc_unreliable("_set_position", global_transform.origin)
	if Input.is_action_pressed("left"):
		input_dir += -camera.global_transform.basis.x
		rpc_unreliable("_set_position", global_transform.origin)
	if Input.is_action_pressed("right"):
		input_dir += camera.global_transform.basis.x
		rpc_unreliable("_set_position", global_transform.origin)
	input_dir = input_dir.normalized()
	return input_dir
