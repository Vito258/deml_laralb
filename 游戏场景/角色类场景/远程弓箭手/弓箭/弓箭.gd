extends Area2D

var vec_x = 1
var has_hit = false  # 标记箭是否已经射中目标

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if vec_x < 0 :
		#$Sprite2D.flip_h = true
		# 或者使用：
		self.scale.x = -1
	
func _physics_process(delta: float) -> void:
	if not has_hit:
		self.position.x += vec_x
		var arr : Array =  $".".get_overlapping_bodies()
		for i in arr:
			if i.is_in_group("player") :
				has_hit = true
				i.take_hit(10)
				queue_free()  # 销毁箭
	
	

# 防止计算机资源的消耗，设置弓箭的最长飞行时间
func _on_timer_timeout() -> void:
	queue_free()
