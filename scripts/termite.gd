extends Node2D

var oldPos:Vector2
const linePreload := preload("res://scenes/line.tscn")
var currentLine
var woodMultiplier 

@onready var linesContainer = $"../linesContainer"
@onready var wood = $"../wood"

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

func _draw() -> void:
	pass

func moved():
	print("moved")
	woodMultiplier = 1+(GLOBAL.noise.get_noise_2d(position.x-wood.position.x-GLOBAL.noise.offset.x,position.y-wood.position.y-GLOBAL.noise.offset.y))
	if linesContainer:
		currentLine.add_point(global_position)

func _on_connect_path_timeout() -> void:
	pass
	
	
	
	
	
