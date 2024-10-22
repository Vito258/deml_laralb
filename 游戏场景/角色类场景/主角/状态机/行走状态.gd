extends Basic_State_Player

@onready
var ani:AnimationPlayer = $"../../AnimationPlayer"

@onready
var player = $"../.."

@onready
var a1:Area2D = $"../../AttackCheck/A1"
@onready
var a2:Area2D = $"../../AttackCheck/A2"
@onready
var a3:Area2D = $"../../AttackCheck/A3"

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var direct : Vector2 = Vector2.RIGHT
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# 防止重复攻击，当attack 为false 时才进行攻击
var attack : bool = false

func enter():
	ani.play("走动动画")
	pass
	
func do():
	# 基础的移动
	# 当玩家不在地板上时,切换下落状态
	if !player.is_on_floor() && player.velocity.y > 0 :
		get_parent().change_state(3)
	var vec:Vector2 = Vector2.ZERO
	vec.x = Input.get_axis("向左走","向右走")
	# 当玩家站立时，切换到站立状态
	if vec.x ==0:
		get_parent().change_state(2)
		return
	# 向右走
	elif vec.x > 0:
		$"../../AnimatedSprite2D".flip_h = false
		$"../../AttackCheck".scale.x = 1
	elif vec.x < 0:
		$"../../AnimatedSprite2D".flip_h = true
		$"../../AttackCheck".scale.x = -1
		
	if Input.is_action_just_released("跳跃"):
		get_parent().change_state(4)
		return
	elif Input.is_action_just_released("攻击"):
		get_parent().change_state(1)
		return
	player.velocity = Vector2(0,1)
	# 如果没有这句代码我们就无法判断角色是不是在地板上
	player.move_and_slide() 
	
func exit():
	pass
