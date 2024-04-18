extends Node3D

@onready var path_follow = $track_and_path/Path3D/PathFollow3D
@onready var car = $track_and_path/Path3D/PathFollow3D/car
@onready var volume_camera_container = $volume_camera_container
@onready var change_view_button: StaticBody3D = $change_view_button

var camera_following_car = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	const move_speed = 3.0
	const SPEED = 10
	path_follow.progress += move_speed * delta
	if camera_following_car:
		volume_camera_container.global_basis = volume_camera_container.global_basis.slerp(path_follow.basis, delta * SPEED)
		volume_camera_container.global_position = lerp(volume_camera_container.global_position, car.global_position, delta)
		print(path_follow.basis.get_rotation_quaternion())
		#volume_camera_container.global_rotation = lerp(volume_camera_container.global_rotation, car.global_rotation, delta)
		#volume_camera_container.scale = lerp(volume_camera_container.scale, Vector3(0.1, 0.1, 0.1), delta)
	else:
		volume_camera_container.global_position = lerp(volume_camera_container.global_position, Vector3(0,0,0), delta)
		volume_camera_container.global_rotation = lerp(volume_camera_container.global_rotation, Vector3(0, 0, 0), delta)
		volume_camera_container.scale = lerp(volume_camera_container.scale, Vector3(1, 1, 1), delta)
		
func _on_change_view_button_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			camera_following_car = !camera_following_car
			print("button pressed")
			print(camera_following_car) 
