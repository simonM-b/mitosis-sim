extends Node2D

@onready var size = $size.size
@onready var cellContainer = $cellContainer
@onready var frameTimer = $"next frame"

const cellPreload = preload("res://scenes/cell.tscn")
var initDraw = true
var drawPosition:Vector2 = Vector2(0,0)
var drawCellArray = []
var cursorColor = Color(Color.BLACK,0.3)
var playState = "no cell action"

var frame = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !true: # turn this on when ur gonna share the game
		OS.shell_open(ProjectSettings.globalize_path("res://docs/"))

func _draw():
	draw_rect(Rect2(0, 0, size.x, size.y), Color.GREEN)
	draw_rect(Rect2(drawPosition.x-0.5, drawPosition.y-0.5, 1, 1), cursorColor)
	
	for cell in drawCellArray:
		draw_rect(Rect2(cell.x-0.5, cell.y-0.5, 1, 1), Color.BLACK)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		drawPosition = event.position
		queue_redraw()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			drawCellArray.append(event.position)
			queue_redraw()
		
	
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event.is_action_pressed("start"):
		frameTimer.start()
		playState = "run cell"
	
	if event.is_action_pressed("stop"):
		frameTimer.stop()
		playState = "no cell action"

func nextFrame():
	print(frame)
	for cell in drawCellArray:
		for NeighborCell in drawCellArray:
			#over by one +x same y 
			#over by -x same y
			#over by +x +y
			#over by +x -y 
			#over by -x +y
			#over by -x -y
			#same x +y
			#same x -y
			if cell.position.x+1 == NeighborCell.position.x:
				print("cell +1x over")
			elif cell.position.x-1 == NeighborCell.position.x:
				print("cell -1x over")
			elif cell.position.y-1 == NeighborCell.position.y:
				print("cell -1y over")
			elif cell.position.y+1 == NeighborCell.position.y:
				print("cell +1y over")
		

func _on_next_frame_timeout() -> void:
	frame += 1
	nextFrame()
	
	
	
	
	
	
	
	
