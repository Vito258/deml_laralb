extends Basic_State_Monster
@onready 
var animated_sprite2d : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready
var monster :CharacterBody2D = $"../.."

func do(): 
	pass

func enter():
	$"../../Audio/Take_Hit".play()
	if monster.health > 0:
		animated_sprite2d.play("受击")
	else:
		animated_sprite2d.play("死亡")
		return
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite2d.animation == "受击":
		get_parent().change_state(0)
	if animated_sprite2d.animation == "死亡":
		monster.queue_free()
