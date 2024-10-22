extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var direct : Vector2 = Vector2.RIGHT

# 防止重复攻击，当attack 为false 时才进行攻击
var attack : bool = false

func _ready() -> void:
	$AnimatedSprite2D.play("移动")
	
func _process(delta: float) -> void:
	# 基础的移动
	if !is_instance_valid($RightDownCast.get_collider()):
		direct = Vector2.LEFT
		$AnimatedSprite2D.flip_h = true
	if !is_instance_valid($LeftDownCast.get_collider()):
		direct = Vector2.RIGHT
		$AnimatedSprite2D.flip_h = false
	
	# 攻击动作
	if direct == Vector2.RIGHT && !attack:
		if is_instance_valid($ArrowRightCast.get_collider()):
			attack = true
			$AnimatedSprite2D.play("攻击")
			# 当进行攻击动作时不会移动，直接return
			return
	if direct == Vector2.LEFT && !attack:
		if is_instance_valid($ArrowLeftCast.get_collider()):
			attack = true
			$AnimatedSprite2D.play("攻击")
			# 当进行攻击动作时不会移动，直接return
			return
	if attack:
		return
	self.velocity = direct*SPEED
	self.velocity.y = get_gravity().y 
	move_and_slide()

# 每次动画切换图片的时候这个函数就会被调用
func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "攻击":
		attack = false
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.play("移动")
	pass # Replace with function body.


func _on_animated_sprite_2d_frame_changed() -> void:
	# 在攻击动作的第8帧 新建弓箭场景
	if $AnimatedSprite2D.animation == "攻击" && $AnimatedSprite2D.frame == 8:
			if direct == Vector2.RIGHT:
				# 新建一个弓箭场景
				var sce_arrow_right = preload("res://游戏场景/角色类场景/远程弓箭手/弓箭/弓箭.tscn").instantiate()
				sce_arrow_right.position = $ArrowRight.global_position
				get_parent().add_child(sce_arrow_right)
			elif direct == Vector2.LEFT:
				# 新建一个弓箭场景
				var sce_arrow_left = preload("res://游戏场景/角色类场景/远程弓箭手/弓箭/弓箭.tscn").instantiate()
				sce_arrow_left.vec_x = -1
				sce_arrow_left.position = $ArrowLeft.global_position
				get_parent().add_child(sce_arrow_left)
