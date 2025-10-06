class_name Player

extends CharacterBody3D

var healthbar
@export var move_speed:float = 15
@export var health: int = 3

var move_inputs: Vector3

func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	healthbar.max_value = health

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("damage_player"):
		damage_player()

func _physics_process(delta: float) -> void:
	read_move_inputs()
	move_inputs *= move_speed * delta
	if move_inputs != Vector3.ZERO:
		velocity = move_inputs * move_speed
		move_and_slide()
	return

func read_move_inputs():
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return
	
func damage_player():
	health -= 1
	healthbar.update(health)
