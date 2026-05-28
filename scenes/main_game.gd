extends Node2D

const termitePreload = preload("res://scenes/termite.tscn")
@onready var termiteContainer = $termiteContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	for i in range(10):
		spawnTermite(Vector2(randi_range(0,1100),randi_range(0,100)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnTermite(pos:Vector2):
	var termite = termitePreload.instantiate()
	termiteContainer.add_child(termite)
	termite.position = pos
	
