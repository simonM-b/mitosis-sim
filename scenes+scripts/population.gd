extends Label

func _process(delta: float) -> void:
	set_text("POPULATION " + str(GLOBAL.cellCount))
