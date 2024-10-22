class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var health = 100

# 玩家的死亡的信号
signal death
func _ready() -> void:
	self.add_to_group("player")
	$CanvasLayer/TextureProgressBar.max_value = health
	$CanvasLayer/TextureProgressBar.value = health

func take_hit(value :int):
	health = health - value
	$CanvasLayer/TextureProgressBar.value = health
	$FSM.change_state(5)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var direction := Input.get_axis("向左走", "向右走")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
