extends Node2D

const termitePreload = preload("res://scenes/termite.tscn")
@onready var termiteContainer = $termiteContainer
@export_range(1,100,1, "prefer_slider") var SpawnAmount: int = 10
@export_group("spawn pos")
@export var spawnMinX = 100
@export var spawnMaxX = 1100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"notif center".spawnNotif("abcd","abcd")
	randomize()
	for i in range(SpawnAmount):
		spawnTermite(Vector2(randi_range(spawnMinX,spawnMaxX),randi_range(0,100)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnTermite(pos:Vector2):
	var termite = termitePreload.instantiate()
	termiteContainer.add_child(termite)
	termite.position = pos
	
