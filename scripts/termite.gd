extends CharacterBody2D

var oldPos:Vector2
const linePreload = preload("res://scenes/line.tscn")
var currentLine
var woodMultiplier 
var fallSpeed = 5000
var woodSpeed = 1000
var onGround = false
var speed
var timerN = 0
var rotation_speed = 2
var Gdelta
var oldTimerTime = 1
var canDrawLine = false
var insideWood = false
var letDrawLineYposOffset = 3

@onready var linesContainer = $"../../linesContainer"
@onready var wood = $"../../wood"
@onready var sprite = $Sprite2D
@onready var dirTimer = $switchDirection


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	oldPos = position
	currentLine = linePreload.instantiate()
	linesContainer.add_child(currentLine)
	speed = fallSpeed
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Gdelta = delta
	if position != oldPos:
		oldPos = position
		moved()
	
	if onGround and insideWood:
		velocity = (speed*woodMultiplier*transform.x)*delta
		#print(velocity.y)
		#print(woodMultiplier)
	else:
		velocity = Vector2(0,speed*delta)
	
	move_and_slide()


func moved():
	#print("moved")
	woodMultiplier = (1+((GLOBAL.noise.get_noise_2d(position.x-wood.position.x-GLOBAL.noise.offset.x,position.y-wood.position.y-GLOBAL.noise.offset.y)*-1)))
	if linesContainer and onGround and canDrawLine:
		if position.y > wood.position.y+letDrawLineYposOffset:
			currentLine.add_point(global_position)



func _on_switch_direction_timeout() -> void:
	var rotationMin = -20
	var rotationMax = 200
	timerN += 1
	var timerTime = (woodMultiplier+0.5)
	#print("timer: ",timerN)
	
	if timerTime > oldTimerTime:
		dirTimer.start(timerTime+0.3)
	else:
		dirTimer.start(timerTime)
	#print(dirTimer.wait_time)
	var rotation_direction
	if timerTime < 0.71:
		rotation_direction = deg_to_rad(randf_range(rotationMin-50,rotationMax+50))
	else:
		rotation_direction = deg_to_rad(randf_range(rotationMin,rotationMax))
		
	var waitRotationTime = 0.8
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", rotation_direction, waitRotationTime)
	
	oldTimerTime = timerTime


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("wood"):
		onGround = true
		$"start drawing line".start()
		speed = woodSpeed
		insideWood = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("wood"):
		insideWood = false


func _on_start_drawing_line_timeout() -> void:
	canDrawLine = true
