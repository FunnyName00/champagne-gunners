extends RigidBody2D

@onready var timer: Timer = $Timer
@onready var eyes : Sprite2D = $eyes


@export var color :Color
@export var impulse_strength := 200
@export var cooldown := 0.8
@export var bullet_speed := 500
@export var maxHealth := 5

var radius := 100 
var canShoot := true
var currentHealth : int
var selfShoot := true

func _ready() -> void:
	$Sprite2D.modulate = color 
	currentHealth = maxHealth

func _physics_process(delta: float) -> void:
	eyes.position = get_local_mouse_position().normalized() * radius
	
	if Input.is_action_pressed("ui_accept"):
		if canShoot: shoot()

func shoot():
	var bullet = preload("res://Scenes/bullet.tscn").instantiate()
	owner.add_child(bullet)
	
	bullet.add_collision_exception_with(self)
	
	get_tree().create_timer(0.2).timeout.connect(
		func(): if is_instance_valid(bullet): bullet.remove_collision_exception_with(self)
	)
	
	var force_direction := (global_position - get_global_mouse_position()).normalized()
	bullet.position = global_position  
	bullet.apply_central_impulse(-force_direction * bullet_speed)
	
	apply_recoil(force_direction)  
	canShoot = false
	timer.start(cooldown) 

func apply_recoil(force_direction):
	apply_central_impulse(force_direction * impulse_strength)

func take_damage(ammout: int):
	currentHealth -= ammout
	print("Player took damages, ", currentHealth, " PV left")
	
func _on_timer_timeout() -> void:
	canShoot = true
  
