extends Node2D

@onready var woodNoise = $"wood noise"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var offsetMin = -10000
	var offsetMax = 10000
	var noise = FastNoiseLite.new()
	noise.fractal_type = 3
	noise.fractal_lacunarity = 1
	noise.fractal_gain = 0.1
	noise.fractal_weighted_strength = 1
	noise.offset = Vector3(0,0,0)
	#noise.offset = Vector3(randf_range(offsetMin,offsetMax),randf_range(offsetMin,offsetMax),0)
	GLOBAL.noise = noise
	woodNoise.texture.noise = noise
	
	
	woodNoise.texture.noise


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_wood_collition_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
