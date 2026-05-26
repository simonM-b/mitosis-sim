extends Node2D

@onready var particleSpawn = $GPUParticles2D2
@onready var spawnTimer = $"move positions"

@export var amountToSpawnPerLocation:float = 1

var listOfPosition = [
Vector2(-478.0,-225.0),
Vector2(358.0,-122.0),
Vector2(-211.0,233.0)]

var currentPosIndex = 0

var amount: float
var amountRatio: float
var lifeSpan: float

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	amount = particleSpawn.amount
	amountRatio = particleSpawn.amount_ratio
	lifeSpan = particleSpawn.lifetime
	
# spawn = amount*ratio
# ratio = spawn/amount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func increaseCount():
	count += 1

func start():
	listOfPosition.append(Vector2(-478.0,-225.0))
	nextPosition()

func nextPosition():
	increaseCount()
	print("emit")
	particleSpawn.position = listOfPosition[currentPosIndex]
	
	particleSpawn.emitting = true
	await wait((lifeSpan/amount)*2)
	particleSpawn.emitting = false
	
	if currentPosIndex < len(listOfPosition)-1:
		currentPosIndex += 1
	else:
		currentPosIndex = 0

func _on_move_positions_timeout() -> void:
	nextPosition()
