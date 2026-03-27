extends RigidBody2D

@export var color :Color
@export var impulse_strength := 200
	
var direction : Vector2
func _ready() -> void:
	$Sprite2D.modulate = color 
  
func _physics_process(delta: float) -> void:
	look_at(get_local_mouse_position())
	
	
	if Input.is_action_just_pressed("ui_accept"):
		shoot()      

func shoot():
	var force_direction := (global_position - get_global_mouse_position()).normalized()
	$".".apply_central_impulse( force_direction * impulse_strength)
