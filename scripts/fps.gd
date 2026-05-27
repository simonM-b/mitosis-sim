extends Label

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("getCount"):
		print("FPS " + str(Engine.get_frames_per_second()))
