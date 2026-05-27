extends Node2D

@onready var size = $size.size
@onready var cellContainer = $cellContainer
@onready var frameTimer = $"next frame"

const cellPreload = preload("res://scenes/cell.tscn")
var initDraw:bool = true
var drawPosition:Vector2 = Vector2(0,0)
var drawCellArray = []
var cursorColor:Color = Color(Color.REBECCA_PURPLE,0.5)

const STOP = "stop"
const PLAY = "play"

var playState:String = STOP

var frame:int = 0
var offset:int = 0
var divisionOffset:int = 2 #the size that the main game is scaled under the render node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !true: # turn this on when ur gonna share the game
		OS.shell_open(ProjectSettings.globalize_path("res://docs/"))

func _draw():
	drawBG()
	drawCells()
	drawCursor()

func _process(delta: float) -> void:
	GLOBAL.playState = playState
	

func drawBG():
	draw_rect(Rect2(0, 0, size.x, size.y), Color.GREEN)

func drawCursor():
	draw_rect(Rect2(drawPosition.x, drawPosition.y, 1, 1), cursorColor)

func drawCells():
	for cell in drawCellArray:
		draw_rect(Rect2(cell.x-offset, cell.y-offset, 1, 1), Color.BLACK)


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _input(event):
	handleMousePress(event)
	handleCursor(event)
	handleKeyBinds(event)

func handleMousePress(event):
	if event is InputEventMouseButton: #handles putting cell down/into the array when there is a mouse left clikc 
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			var x = Vector2(roundf(event.position.x/divisionOffset),roundf(event.position.y/divisionOffset))
			drawCellArray.push_front(x)
			queue_redraw()

func handleCursor(event):
	if event is InputEventMouseMotion: #handles the mouse cursor 
		drawPosition = Vector2(roundf(event.position.x/divisionOffset),roundf(event.position.y/divisionOffset))
		queue_redraw()
		

func handleKeyBinds(event):
	if event is InputEventKey and event.pressed: #when click esc it shows the mouse cursor
		if event.keycode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event.is_action_pressed("start"): #when click space it starts the simulation
		frameTimer.start()
		playState = PLAY

	if event.is_action_pressed("stop"): #when click controll or command it pauses the simulation
		frameTimer.stop()
		playState = STOP


func nextFrame():
	frame += 1
	print("FRAME NUMB: ",frame)
	
	print(drawCellArray)
	
	for cell in drawCellArray:
		var touchingCells = 0
		var duplicateCell = 0
		#print("CELL x:",cell.x," Y:",cell.y)
		for NeighborCell in drawCellArray:
			#over by one +x same y
			#over by -x same y
			#over by +x +y
			#over by +x -y
			#over by -x +y
			#over by -x -y
			#same x +y
			#same x -y
			if cell == NeighborCell:
				duplicateCell += 1
				continue
			elif cell.x+1 == NeighborCell.x and cell.y == NeighborCell.y: #alive cell to the right
				touchingCells += 1
				continue
			elif cell.x-1 == NeighborCell.x and cell.y == NeighborCell.y: #alive cell to the left
				touchingCells += 1
				continue
			elif cell.y-1 == NeighborCell.y and cell.x == NeighborCell.x: #alive cell above
				touchingCells += 1
				continue
			elif cell.y+1 == NeighborCell.y and cell.x == NeighborCell.x: #alive cell left
				touchingCells += 1
				continue
			elif cell.x-1 == NeighborCell.x and cell.y-1 == NeighborCell.y: #top left corner
				touchingCells += 1
				continue
			elif cell.x+1 == NeighborCell.x and cell.y-1 == NeighborCell.y: #top right corner
				touchingCells += 1
				continue
			elif cell.x-1 == NeighborCell.x and cell.y+1 == NeighborCell.y: #botom left corner
				touchingCells += 1
				continue
			elif cell.x+1 == NeighborCell.x and cell.y+1 == NeighborCell.y: #bottom right corner
				touchingCells += 1
				continue
		
		if duplicateCell > 1:
			drawCellArray.erase(cell)
				
		if touchingCells == 8:
			await wait(0.1)
			drawCellArray.erase(cell)
		
	queue_redraw()


func _on_next_frame_timeout() -> void:
	nextFrame()
