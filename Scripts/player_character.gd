extends RigidBody2D

@onready var timer: Timer = $Timer
@onready var eyes : Sprite2D = $eyes

@export var color :Color
@export var impulse_strength := 200
@export var cooldown := 0.8

var radius := 100 
var canShoot := true

func _ready() -> void:
	$Sprite2D.modulate = color 

func _physics_process(delta: float) -> void:
	eyes.position = get_local_mouse_position().normalized() * radius
	
	if Input.is_action_pressed("ui_accept"):
		if canShoot: shoot()

func shoot():
	var force_direction := (global_position - get_global_mouse_position()).normalized()
	apply_central_impulse( force_direction * impulse_strength)
	canShoot = false
	timer.start(cooldown)

func _on_timer_timeout() -> void:
	canShoot = true
