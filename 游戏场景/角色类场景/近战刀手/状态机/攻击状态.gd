extends Basic_State_Monster
func do():
	pass

func enter():
	# 攻击动画的播放代码	
	# 如果计时器停止，播放1号攻击动画
	if $Timer.is_stopped():
		$"../../AnimationPlayer".play("攻击1")
	else :
		$"../../AnimationPlayer".play("攻击2")
	pass
	
# 编写一个攻击检测函数
func attack1_check():
	var arr: Array = $"../../AttackCheck/A1".get_overlapping_bodies()
	# 检测攻击范围内是否有玩家
	for i in arr:
		if i.is_in_group("player") :
			i.take_hit(10)

func attack2_left_check():
	var arr: Array = $"../../AttackCheck/A2L".get_overlapping_bodies()
	# 检测攻击范围内是否有玩家
	for i in arr:
		if i.is_in_group("player") :
			i.take_hit(10)
		
func attack2_right_check():
	var arr :Array = $"../../AttackCheck/A2R".get_overlapping_bodies()
	# 检测攻击范围内是否有玩家
	for i in arr:
		if i.is_in_group("player") :
			i.take_hit(10)

# 将AnimatedSprite2D 的动画播放完成的信号连接到Attack 节点内
func _on_animated_sprite_2d_animation_finished() -> void:
	if $"../../AnimatedSprite2D".animation == "攻击1":
		$Timer.start(0.25)
	if $"../../AnimatedSprite2D".animation == "攻击1" || $"../../AnimatedSprite2D".animation == "攻击2":
		$"../../AnimatedSprite2D".frame = 0
		# 回归到跑动状态
		get_parent().change_state(0)
	pass # Replace with function body.
