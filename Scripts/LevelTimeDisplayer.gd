extends Node2D

onready var global = get_node("/root/global")
var start_time = 0

func on_level_start(level_nb):
	start_time = global.total_time

func _process(delta):
	if Input.is_action_just_pressed("timer_display"):
		$TimeLabel.visible = not $TimeLabel.visible
		global.display_detail = $TimeLabel.visible
	
	if $TimeLabel.visible:
		var text = ""
		
		var time = global.total_time
		var minute = floor(time / 60)
		var second = ceil(time - minute * 60)
		var text_second = str(second)
		if second < 10:
			text_second = "0" + text_second
		var text_minute = str(minute)
		if minute < 10:
			text_minute = "0" + text_minute
		text = text_minute + ":" + text_second
		
		time = global.total_time - start_time
		minute = floor(time / 60)
		second = ceil(time - minute * 60)
		text_second = str(second)
		if second < 10:
			text_second = "0" + text_second
		text_minute = str(minute)
		if minute < 10:
			text_minute = "0" + text_minute
		
		$TimeLabel.text = text + '\n' + text_minute + ":" + text_second
