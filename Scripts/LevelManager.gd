extends Node2D

var levels = ['001', '002', '003', '004', '005', '006', '007', '008']
var current_level := 0
var current_level_scene = null

func _ready():
	load_current_level()

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		load_current_level()

func load_current_level():
	#clean up
	if current_level_scene != null:
		$LevelScene.remove_child(current_level_scene)
		
	current_level_scene = load('res://Levels/Level' + levels[current_level] + '.tscn').instance()

	#load level
	$LevelScene.add_child(current_level_scene)
	current_level_scene.connect("on_level_end", self, "on_level_end")
	$Camera2D.zoom = current_level_scene.camera_zoom
	
	print("level started")
	

func on_level_end():
	print("GG")
	current_level = (current_level + 1) % levels.size()
	load_current_level()
