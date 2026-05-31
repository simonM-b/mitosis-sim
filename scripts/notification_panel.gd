extends Panel

@onready var title = $MarginContainer/VBoxContainer/title
@onready var text = $MarginContainer/VBoxContainer/text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if modulate.a < 0.2:
		queue_free()

func dissapearSowley(sec):
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "modulate:a", 0, sec)
	await tween.finished
	queue_free()
