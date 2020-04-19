extends StaticBody2D

var _is_opened = false

export var is_reversed = false
onready var collision_shape : CollisionShape2D = $CollisionShape2D
onready var sprite : Sprite = $Sprite


func _ready():
	if is_reversed:
		toggle_door()

func toggle_door():
	_is_opened = not _is_opened
	sprite.visible = not sprite.visible
	collision_shape.set_deferred("disabled", not collision_shape.disabled)

func on_button_pushed():
	toggle_door()


func _on_Button_on_button_pushed():
	toggle_door()

