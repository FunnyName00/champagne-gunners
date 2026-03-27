extends Sprite2D

@export var radius := 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dist = position.distance_to(get_local_mouse_position())
	global_position = clamp(dist, radius, radius)
	
