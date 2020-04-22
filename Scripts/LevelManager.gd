extends Node2D

signal level_start(level_nb)

var levels = ['Title', '001', '002', '003', \
			'101', '103', '104', '105', \
			'200', '201', '202', '204',\
			'300', '301', '302', '303', '304',\
			'400', '401', '402', '403', '404', '405',\
			'End', '500', '501']
var current_level := 0
var current_level_scene = null
var was_alive = false
var _level_loading_in_progress = false

onready var global = get_node("/root/global")

func _ready():
	load_current_level()
	$Heart.connect("anim_end", self, "on_anim_end")
	$HeartBroken.connect("end_level_anim_end", self, "on_anim_end")
	$Heart.connect("start_level_anim_end", self, "on_start_level_anim_end")
	$HeartBroken.connect("start_level_anim_end", self, "on_start_level_anim_end")

	self.connect("level_start", global, "on_level_start")

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		if not _level_loading_in_progress:
			load_current_level()
	if not _level_loading_in_progress:
		if Input.is_action_just_pressed("prev_level"):
			on_level_end(false)
			current_level = (current_level - 1 + levels.size()) % levels.size()
		if Input.is_action_just_pressed("next_level"):
			on_level_end(false)
			current_level = (current_level + 1) % levels.size()
		
	if current_level_scene != null:
		$UI/Label.text = 'Level ' + levels[current_level]

func load_current_level():
	#clean up
	if current_level_scene != null:
		$LevelScene.remove_child(current_level_scene)
		
	current_level_scene = load('res://Levels/Level' + levels[current_level] + '.tscn').instance()

	#load level
	$LevelScene.add_child(current_level_scene)
	current_level_scene.connect("on_level_end", self, "on_level_end")
	$Camera2D.zoom = current_level_scene.camera_zoom
	
	if was_alive:
		$Heart.play_start_level_transition()
	else :
		$HeartBroken.play_start_level_transition()
	
	emit_signal("level_start", current_level)

func on_level_end(is_alive):
	_level_loading_in_progress = true
	was_alive = is_alive
	
	if is_alive:
		current_level = (current_level + 1) % levels.size()
		$Heart.play_end_level_transition()
	else:
		$HeartBroken.play_end_level_transition()

func on_anim_end():
	load_current_level()

func on_start_level_anim_end():
	_level_loading_in_progress = false

func get_time_ratio_before_rope_breaks():
	return current_level_scene.get_time_ratio_before_rope_breaks()
