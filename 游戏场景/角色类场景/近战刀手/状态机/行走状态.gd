extends Basic_State_Monster

@onready
var ani:AnimationPlayer = $"../../AnimationPlayer"

@onready
var monster:CharacterBody2D = $"../.."

@onready
var a1:Area2D = $"../../AttackCheck/A1"
@onready
var a2l:Area2D = $"../../AttackCheck/A2L"
@onready
var a2r:Area2D = $"../../AttackCheck/A2R"

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var direct : Vector2 = Vector2.RIGHT
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# 防止重复攻击，当attack 为false 时才进行攻击
var attack : bool = false

func enter():
	ani.play(&"走动动画")
	pass
	
func do():
	# 基础的移动
	if !is_instance_valid($"../../RightDownCast".get_collider()):
		direct = Vector2.LEFT
		$"../../AttackCheck".scale.x = -1
		$"../../AnimatedSprite2D".flip_h = true
	if !is_instance_valid($"../../LeftDownCast".get_collider()):
		direct = Vector2.RIGHT
		$"../../AttackCheck".scale.x = 1
		$"../../AnimatedSprite2D".flip_h = false
	
	# 攻击动作
	var arr:Array = a1.get_overlapping_bodies();
	var attack_ready : bool = false
	for i in arr:
		if i.is_in_group("player") :
			attack_ready = true
	if attack_ready :
		# 转换为攻击状态
		get_parent().change_state(1)
		return
	monster.velocity = direct*SPEED
	monster.velocity.y = gravity
	monster.move_and_slide()
	
func exit():
	pass
