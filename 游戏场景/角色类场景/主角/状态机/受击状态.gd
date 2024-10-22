extends Basic_State_Player

@onready 
var animated_sprite2d : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready
var player :CharacterBody2D = $"../.."

var speed = 200


func do(): 
	pass

func enter():
	$"../../Audio/Take_Hit".play()
	if player.health > 0:
		animated_sprite2d.play("受击")
	else:
		animated_sprite2d.play("死亡")
		await get_tree().create_timer(3)
		player.emit_signal("death")
		return
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite2d.animation == "受击":
		get_parent().change_state(2)
	if animated_sprite2d.animation == "死亡":
		# 发射死亡信号
		player.emit_signal("death")
