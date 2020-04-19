extends Sprite

export var pupil_offset: float = 4.0
var is_mouse_target = true
var target : Vector2
export var scale_pupil : float = 1
var owner_rigid_body : RigidBody2D

func _ready():
	$Pupil.scale = $Pupil.scale * scale_pupil

func initialize(character : RigidBody2D):
	owner_rigid_body = character

func _process(delta):
	if is_mouse_target:
		if owner_rigid_body is Girl or owner_rigid_body.linear_velocity.length() < 10:
			update_eye_position(get_global_mouse_position())
		else:
			var target = owner_rigid_body.global_position + owner_rigid_body.linear_velocity
			update_eye_position(target)
	else:
		update_eye_position(target)
		
		
func set_target(position : Vector2):
	target = position
	is_mouse_target = false
	
func set_mouse_target():
	is_mouse_target = true
		
func update_eye_position(target : Vector2):
	var direction = (target - global_position).normalized()
	
	$Pupil.global_position = global_position + direction * pupil_offset
