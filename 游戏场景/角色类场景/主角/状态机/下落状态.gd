extends Basic_State_Player

@onready 
var animated_sprite2d : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready
var player :CharacterBody2D = $"../.."

var speed = 200

func enter():
	animated_sprite2d.play("下落")
func do():
	if player.is_on_floor():
		get_parent().change_state(2)
		return
	var vec : Vector2 = Vector2.ZERO
	vec.x = Input.get_axis("向左走","向右走")
	player.velocity.x = vec.x * speed
	player.velocity.y = player.velocity.y + 1
	player.move_and_slide()
