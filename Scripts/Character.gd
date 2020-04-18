extends RigidBody2D
class_name Character

var is_dragging : bool = false
var position_click_start : Vector2
export var impulse_multiplier : float = 30.0
export var max_impulse_length : float = 120.0
export var can_move : bool = true

var old_velocity = Vector2(0, 0)

func _ready():
	pass

func _process(delta):
	old_velocity = linear_velocity
	
func _input(event):
	if is_dragging and event is InputEventMouseButton and not event.pressed and event.button_index == BUTTON_LEFT:
		_expulse()
		is_dragging = false

func _on_RigidBody2D_input_event(viewport, event, shape_idx):
	if can_move and event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		position_click_start = get_global_mouse_position()
		is_dragging = true


func _expulse():
	var impulse : Vector2 = get_current_dragging_impulse_vector() * impulse_multiplier
	apply_central_impulse(impulse)

func get_current_dragging_impulse_vector():
	var position_click_released : Vector2 = get_global_mouse_position()
	var impulse_vector = (position_click_start - position_click_released)
	var length = min(impulse_vector.length(), max_impulse_length)
	return impulse_vector.normalized() * length


func _on_RigidBody2D_body_entered(body):
	if body is ButtonPush:
		body.on_collide_player(self)
