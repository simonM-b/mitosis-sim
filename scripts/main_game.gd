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
var isDriagging = false

var frame:int = 0
var offset:int = 0
var divisionOffset:int = 2 #the size that the main game is scaled under the render node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !true: # turn this on when ur gonna share the game
		OS.shell_open(ProjectSettings.globalize_path("res://docs/"))

func _draw() -> void:
	drawBG()
	drawCells()
	drawCursor()

func _process(delta: float) -> void:
	GLOBAL.playState = playState
	if Input.is_action_pressed("click"):
		isDriagging = true
	else:
		isDriagging = false
	
	
	

func drawBG() -> void:
	draw_rect(Rect2(0, 0, size.x, size.y), Color.GREEN)

func drawCursor() -> void:
	draw_rect(Rect2(drawPosition.x, drawPosition.y, 1, 1), cursorColor)

func drawCells() -> void:
	if len(drawCellArray) > 0:
		for cell in drawCellArray:
			draw_rect(Rect2(cell[0].x-offset, cell[0].y-offset, 1, 1), cell[1])

func addCell(pos:Vector2,color:Color) -> void:
	var cellInfo = [pos,color]
	if len(drawCellArray) > 0:
		if pos != drawCellArray[0][0]:
			drawCellArray.push_front(cellInfo)
		else:
			pass
			#print("SAME LOCATION")
	else:
		drawCellArray.push_front(cellInfo)

func duplicate1Cell(cell,neighbor):
	var cellX = cell[0].x
	var cellY = cell[0].y
	
	var neighX = neighbor[0].x
	var neighY = neighbor[0].y
	
	var newX = cellX-neighX
	var newY = cellY-neighY
	
	var newCellPos = Vector2(cellX+1,cellY-1)
	addCell(newCellPos,Color.ORANGE_RED)
	


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _input(event):
	handleMousePress(event)
	handleCursor(event)
	handleKeyBinds(event)
	
func mouseSpawnCellProcedure(event) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	addCell(Vector2(roundf(event.position.x/divisionOffset),roundf(event.position.y/divisionOffset)),Color.BLACK)
	queue_redraw()
	
func handleMousePress(event):
	if event is InputEventMouseMotion:
		if isDriagging:
			mouseSpawnCellProcedure(event)
	if event.is_action_pressed("click"):
		mouseSpawnCellProcedure(event)

		

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
	
	#print(drawCellArray)
	
	for cell in drawCellArray:
		var cellPos = cell[0]
		var touchingCells = 0
		var duplicateCell = 0
		var neighborO
		#print("CELL x:",cell.x," Y:",cell.y)
		for NeighborCell in drawCellArray:
			var NeighnorPos = NeighborCell[0]
			neighborO = NeighborCell
			if cellPos == NeighnorPos:
				duplicateCell += 1
				continue
			elif cellPos.x+1 == NeighnorPos.x and cellPos.y == NeighnorPos.y: #alive cell to the right
				touchingCells += 1
				continue
			elif cellPos.x-1 == NeighnorPos.x and cellPos.y == NeighnorPos.y: #alive cell to the left
				touchingCells += 1
				continue
			elif cellPos.y-1 == NeighnorPos.y and cellPos.x == NeighnorPos.x: #alive cell above
				touchingCells += 1
				continue
			elif cellPos.y+1 == NeighnorPos.y and cellPos.x == NeighnorPos.x: #alive cell left
				touchingCells += 1
				continue
			elif cellPos.x-1 == NeighnorPos.x and cellPos.y-1 == NeighnorPos.y: #top left corner
				touchingCells += 1
				continue
			elif cellPos.x+1 == NeighnorPos.x and cellPos.y-1 == NeighnorPos.y: #top right corner
				touchingCells += 1
				continue
			elif cellPos.x-1 == NeighnorPos.x and cellPos.y+1 == NeighnorPos.y: #botom left corner
				touchingCells += 1
				continue
			elif cellPos.x+1 == NeighnorPos.x and cellPos.y+1 == NeighnorPos.y: #bottom right corner
				touchingCells += 1
				continue
		
		if duplicateCell > 1: #erases the cell if it already exists
			drawCellArray.erase(cell)
		
		#rules
		
		if touchingCells >= 4: #if a cell has more than 4 neoghbots it dies
			drawCellArray.erase(cell)
		
		if touchingCells == 1: #duplicates the cell if there is exactly one
			duplicate1Cell(cell,neighborO)
		
	queue_redraw()


func _on_next_frame_timeout() -> void:
	nextFrame()
