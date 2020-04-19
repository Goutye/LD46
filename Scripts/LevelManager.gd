extends Node2D

var levels = ['001', '002', '003', '004', '005', '006', '007', '008', '009']
var current_level := 0
var current_level_scene = null

func _ready():
	load_current_level()
	$Heart.connect("anim_end", self, "on_anim_end")

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		load_current_level()
	if Input.is_action_just_pressed("prev_level"):
		on_level_end(false)
		current_level = (current_level - 1 + levels.size()) % levels.size()
	if Input.is_action_just_pressed("next_level"):
		on_level_end(false)
		current_level = (current_level + 1) % levels.size()
		
	if current_level_scene != null:
		$Label.text = str(current_level_scene.get_nb_collisions())

func load_current_level():
	#clean up
	if current_level_scene != null:
		$LevelScene.remove_child(current_level_scene)
		
	current_level_scene = load('res://Levels/Level' + levels[current_level] + '.tscn').instance()

	#load level
	$LevelScene.add_child(current_level_scene)
	current_level_scene.connect("on_level_end", self, "on_level_end")
	$Camera2D.zoom = current_level_scene.camera_zoom
	
	$Heart.play_start_level_transition()
	print("level started")
	

func on_level_end(is_alive):
	if is_alive:
		print("GG")
		current_level = (current_level + 1) % levels.size()
	else:
		print("dead -> restart")
	$Heart.play_end_level_transition()
	

func on_anim_end():
	load_current_level()
