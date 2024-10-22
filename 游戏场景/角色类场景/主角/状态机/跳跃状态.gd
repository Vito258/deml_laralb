extends Basic_State_Player

@onready 
var animated_sprite2d : AnimatedSprite2D = $"../../AnimatedSprite2D"

@onready
var player : CharacterBody2D = $"../.."

var speed = 200
var jump_speed = -400
var is_jumping :bool = false

func enter():
	animated_sprite2d.play("预跳跃")
	await animated_sprite2d.animation_finished
	if animated_sprite2d.animation == "预跳跃":
		animated_sprite2d.frame = 0
		
		$"../../AnimationPlayer".play("跳跃")
		is_jumping = true
		player.velocity.y = jump_speed
		await animated_sprite2d
		
func do():
	if is_jumping:
		# 转到下落状态
		if !player.is_on_floor() && player.velocity.y > 0:
			get_parent().change_state(3)
			return
	var vec:Vector2 = Vector2.ZERO
	vec.x = Input.get_axis("向左走","向右走")
	player.velocity.x = vec.x * speed
	player.velocity.y = player.velocity.y + 2
	player.move_and_slide()

func exit() :
	player.velocity.y = 0
	is_jumping = false
	 
