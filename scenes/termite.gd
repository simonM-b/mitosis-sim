extends CharacterBody2D

var oldPos:Vector2
const linePreload = preload("res://scenes/line.tscn")
var currentLine
var woodMultiplier 
var fallSpeed = 5000
var onGround = false

@onready var linesContainer = $"../../linesContainer"
@onready var wood = $"../../wood"
@onready var sprite = $Sprite2D
@onready var dirTimer = $switchDirection

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
	if global_position.y + (sprite.texture.get_height()*sprite.scale.y)/2 < wood.position.y:
		velocity.y = fallSpeed*delta
	else:
		velocity.y = 0
		onGround = true
	move_and_slide()

func _draw() -> void:
	pass

func moved():
	print("moved")
	woodMultiplier = 1+(GLOBAL.noise.get_noise_2d(position.x-wood.position.x-GLOBAL.noise.offset.x,position.y-wood.position.y-GLOBAL.noise.offset.y))
	if linesContainer and onGround:
		currentLine.add_point(global_position)



func _on_switch_direction_timeout() -> void:
	dirTimer.start(randf_range(0.4,0.6)*woodMultiplier)
