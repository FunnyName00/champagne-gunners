extends RigidBody2D

@export var color :Color
@export var impulse_strength := 200

@onready var timer: Timer = $Timer

var radius := 100 
var canShoot := true

func squareVect2(vector: Vector2):
	#print(vector.x) 
	return Vector2(vector.x ** 2, vector.y ** 2)

func _ready() -> void:
	$Sprite2D.modulate = color 

func _physics_process(delta: float) -> void:
	$eyes.position = get_local_mouse_position().normalized() * radius
	
	if Input.is_action_just_pressed("ui_accept"):
		if canShoot: shoot()

func shoot():
	var force_direction := (global_position - get_global_mouse_position()).normalized()
	apply_central_impulse( force_direction * impulse_strength)
	canShoot = false
	timer.start()

func _on_timer_timeout() -> void:
	canShoot = true
