extends Control

const notifPreload = preload('res://scenes/notification_panel.tscn')
@onready var container = $container

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawnDebugNotif"):
		print("actionPressed")
		spawnNotif("test Title","test Text")
	
func spawnNotif(title:String,text:String,hideSpeed:float=10.0):
	var notif = notifPreload.instantiate()
	container.add_child(notif)
	notif.title.text = title
	notif.text.text = text
	notif.dissapearSowley(hideSpeed)
	
