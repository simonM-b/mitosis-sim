extends Node2D

const cellPreload = preload("res://cell.tscn")
@onready var cellsContainer = $cells


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var cell = cellPreload.instantiate()
	cellsContainer.add_child(cell)
	cell.position = Vector2(randi_range(0,1000),randi_range(0,600))
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
