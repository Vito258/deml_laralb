extends Basic_State_Player

var attack_index : int = 0

@onready
var animated_sprite2d : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready
var timer :Timer = $Timer

func enter():
	# 攻击动画的播放代码	
	# 如果计时器停止，播放1号攻击动画
	if timer.is_stopped():
		if attack_index == 0:
			$"../../AnimationPlayer".play("攻击1")
		elif attack_index == 1 :
			$"../../AnimationPlayer".play("攻击2")
		elif attack_index == 2 :
			$"../../AnimationPlayer".play("攻击3")
	
# 编写一个攻击检测函数
func attack1_check():
	var arr: Array = $"../../AttackCheck/A1".get_overlapping_bodies()
	# 检测攻击范围内是否有怪物
	for i in arr:
		if i.is_in_group("monster") :
			i.take_hit(10)

func attack2_check():
	var arr: Array = $"../../AttackCheck/A2".get_overlapping_bodies()
	# 检测攻击范围内是否有怪物
	for i in arr:
		if i.is_in_group("monster") :
			i.take_hit(10)
		
func attack3_check():
	var arr :Array = $"../../AttackCheck/A3".get_overlapping_bodies()
	# 检测攻击范围内是否有怪物
	for i in arr:
		if i.is_in_group("monster") :
			i.take_hit(10)


func do():
	pass

# 将AnimatedSprite2D 的动画播放完成的信号连接到Attack 节点内
#func _on_animated_sprite_2d_animation_finished() -> void:
	#if animated_sprite2d.animation == "攻击1" || animated_sprite2d.animation == "攻击2" || animated_sprite2d.animation == "攻击3":
		#attack_index +=1
		#if attack_index == 3:
			#attack_index = 0
		#$Timer.start(0.25)
		## 切换回站立
		#get_parent().change_state(2)
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite2d.animation in ["攻击1", "攻击2", "攻击3"]:
		attack_index = (attack_index + 1) % 3
		timer.start(0.25)
		

func exit():
	timer.stop()
	$"../../AnimationPlayer".stop()
	animated_sprite2d.frame = 0

func attack_check():
	var arr : Array =[]
	if attack_index == 0 :
		arr = $"../../AttackCheck/A1".get_overlapping_bodies()
	elif attack_index == 1:
		arr = $"../../AttackCheck/A2".get_overlapping_bodies()
	else :
		arr = $"../../AttackCheck/A3".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("monster") :
			i.take_hit(10)
	

func _on_timer_timeout():
	get_parent().change_state(2)  # 假设 2 是站立状态
	
