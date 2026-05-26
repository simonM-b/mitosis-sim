extends Node2D

const cellPreload = preload("res://cell.tscn")
var cellsContainer
@onready var lifeSpanTimer: Timer = $lifespan
@onready var cloneTimer: Timer = $clone

@export var minSpawnDistance: int = -50
@export var maxSpawnDistance: int = 50

@export var turnColorAtTimeLeft: float = 0.5
var oneshotDeath = true

var mutationClone
var mutationLife

@export var cloneTime: float = 3.0
@export var lifeTime: float = 4.0

var cloneTimeReal: float = 0
var lifeTimeReal: float = 0

var spawnQ: bool = false

var touchingCellCount = 0
var maxCellTouching = 30

var oneTimer1 = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("NEW CELL ",GLOBAL.cellCount)
	randomize()
	mutationClone = randf_range(-0.01,0.01)
	mutationLife = randf_range(-0.01,0.01)
	cellsContainer = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(lifeSpanTimer.time_left)
	handelDeathColor()
	if GLOBAL.cellCount < GLOBAL.maxCells:
		if spawnQ:
			cloneCell()
			spawnQ = false
	if touchingCellCount >= maxCellTouching:
		die()
	#print("CLONE",cloneTimer.time_left)
	#print("LIFE",lifeSpanTimer.time_left)

func handelDeathColor():
	if lifeSpanTimer.time_left < turnColorAtTimeLeft and oneshotDeath == true:
		oneshotDeath = false
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.RED, turnColorAtTimeLeft)

func cloneCell():
	#print("cell cloned")
	var cell = cellPreload.instantiate()
	cellsContainer.add_child(cell)
	cell.cloneTime = cloneTime+mutationClone
	cell.lifeTime = lifeTime+mutationLife
	cell.position = Vector2(position.x+randi_range(minSpawnDistance,maxSpawnDistance),position.y+randi_range(minSpawnDistance,maxSpawnDistance))

func die():
	#GLOBAL.cellCount -= 1
	queue_free()

func _on_clone_timeout() -> void:
	if GLOBAL.cellCount < GLOBAL.maxCells:
		cloneCell()
	else:
		spawnQ = true
	

func _on_lifespan_timeout() -> void:
	die()

func _on_init_timeout() -> void:
	lifeSpanTimer.wait_time = lifeTime + lifeTimeReal
	cloneTimer.wait_time = cloneTime - cloneTimeReal
	cloneTimer.start()
	lifeSpanTimer.start()
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("fastGrowth"):
		#print("fast growth")
		cloneTimeReal = cloneTime/2
		lifeTimeReal = lifeTime/2
	if area.is_in_group("cell"):
		touchingCellCount += 1


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("cell"):
		touchingCellCount -= 1
