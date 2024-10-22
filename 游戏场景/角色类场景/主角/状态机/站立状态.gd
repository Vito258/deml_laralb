extends Basic_State_Player
@onready
var player : CharacterBody2D = $"../.."
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	$"../../AnimatedSprite2D".play("站立")
	pass
func do():
	# 当玩家不在地板上时,切换下落状态
	if !player.is_on_floor && player.velocity.y > 0:
		get_parent().change_state(3)
		return
	var vec:Vector2 = Vector2.ZERO
	vec.x = Input.get_axis("向左走","向右走")
	# 当玩家移动时，切换到移动状态
	if vec.x !=0:
		get_parent().change_state(0)
		return
	elif Input.is_action_just_released("跳跃"):
		get_parent().change_state(4)
		return
	elif Input.is_action_just_released("攻击"):
		get_parent().change_state(1)
		return
	player.velocity = Vector2(0,1)
	# 如果没有这句代码我们就无法判断角色是不是在地板上
	player.move_and_slide() 
	
	
