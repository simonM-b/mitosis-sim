extends Node2D

var oldPos:Vector2
const linePreload := preload("res://scenes/line.tscn")
var currentLine

@onready var linesContainer = $"../linesContainer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	oldPos = position
	currentLine = linePreload.instantiate()
	linesContainer.add_child(currentLine)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position != oldPos:
		oldPos = position
		moved()
	print(GLOBAL.noise.get_noise_2d(position.x,position.y))

func _draw() -> void:
	pass

func moved():
	print("moved")
	if linesContainer:
		currentLine.add_point(global_position)

func _on_connect_path_timeout() -> void:
	pass
	
	
	
	
	
