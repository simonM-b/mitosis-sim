extends Node2D

const cellPreload = preload("res://cell.tscn")
@onready var cellsContainer = $cells


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	if !true:
		var cell = cellPreload.instantiate()
		cellsContainer.add_child(cell)
		cell.position = Vector2(randi_range(0,1000),randi_range(0,600))
	
	

func checkandSetChildCount():
	var id = 0
	for i in $cells.get_children():
		id += 1
	GLOBAL.cellCount = id
	return id

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("getCount"):
		print("THERE ARE ",checkandSetChildCount()," CHILDREN")
			


func _on_check_children_timeout() -> void:
	checkandSetChildCount()
