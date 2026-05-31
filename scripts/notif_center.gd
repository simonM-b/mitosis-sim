extends Control

const notifPreload = preload("res://scenes/notif_panel.tscn")
@onready var notifContainer = $"HBoxContainer/MarginContainer/notif container"

var idNumber = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnNotif(title,text):
	idNumber += 1
	var notif = notifPreload.instantiate()
	notifContainer.add_child(notif)
	notif.id.text = str(idNumber)
	notif.title.text = title
	notif.mainText.text = text
	
	
	
	
	
	
