extends RigidBody2D
class_name Character

var is_dragging : bool = false
export var impulse_multiplier : float = 30.0
export var max_impulse_length : float = 120.0
export var can_move := true
export var can_track_collisions := false
onready var eye1 = $CollisionShape2D/Sprite/Eye
onready var eye2 = $CollisionShape2D/Sprite/Eye2
onready var smoke_particles = [$CollisionShape2D/ParticlesSmoke/ParticlesSmoke, $CollisionShape2D/ParticlesSmoke/ParticlesSmoke2, $CollisionShape2D/ParticlesSmoke/ParticlesSmoke3]
var nb_collisions := 0
var old_velocity := Vector2(0, 0)
var has_collided_with_girl := false
var is_dead := false

onready var global = get_node("/root/global")

func _ready():
	eye1.initialize(self)
	eye2.initialize(self)

func _process(delta):
	old_velocity = linear_velocity

	if is_dragging:
		var eye_target = get_current_dragging_impulse_vector() + global_position
		eye1.set_target(eye_target)
		eye2.set_target(eye_target)
	
func _input(event):
	if is_dragging and event is InputEventMouseButton and not event.pressed and event.button_index == BUTTON_LEFT:
		_expulse()
		is_dragging = false
		eye1.set_mouse_target()
		eye2.set_mouse_target()

func _on_RigidBody2D_input_event(viewport, event, shape_idx):
	if can_move and event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		is_dragging = true

func _expulse():
	var impulse : Vector2 = get_current_dragging_impulse_vector() * impulse_multiplier
	apply_central_impulse(impulse)
	for smoke_particle in smoke_particles:
		smoke_particle.emitting = true

func get_current_dragging_impulse_vector():
	var position_click_released : Vector2 = get_global_mouse_position()
	var impulse_vector = (global_position - position_click_released)
	var length = min(impulse_vector.length(), max_impulse_length)
	return impulse_vector.normalized() * length


func _on_RigidBody2D_body_entered(body):
	if body is ButtonPush:
		body.on_collide_player(self)
	elif linear_velocity.length_squared() > 100.0:
		if can_track_collisions and not has_collided_with_girl:
			nb_collisions += 1

			if body is BouncingBox:
				body.play_sound()
			else:
				if not $SoundHit.playing or $SoundHit.get_playback_position() > 0.2:
					$SoundHit.play()
			
		for smoke_particle in smoke_particles:
			smoke_particle.emitting = true
		

func on_collision_with_girl(body):
	eye1.set_target(body.position)
	eye2.set_target(body.position)
	has_collided_with_girl = true
		
func on_hit_by_lava():
	if not is_dead:
		global.character_nb_killed += 1
		
		is_dead = true
		flux.to($CollisionShape2D, 0.8, {scale_x = 0.01}, "absolute").ease("quad","out")
		flux.to($CollisionShape2D, 0.8, {scale_y = 0.01}, "absolute").ease("quad","out")
