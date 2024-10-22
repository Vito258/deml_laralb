extends CharacterBody2D

var health : int = 100
func _ready() -> void:
	add_to_group("monster")
	
func take_hit(value: int):
	health = health - value
	$FSM.change_state(2)
