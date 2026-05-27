extends Node2D

@onready var size = $size.size
@onready var cellContainer = $cellContainer

const cellPreload = preload("res://scenes/cell.tscn")
var initDraw = true
var drawPosition:Vector2 = Vector2(0,0)
var drawCellArray = []
var cursorColor = Color(Color.BLACK,0.3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
		
		
		
		
		
