extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_游戏开始界面_game_start() -> void:
	# 游戏开始时添加地图场景
	var s = preload("res://游戏场景/地图场景/地图场景.tscn").instantiate()
	s.connect("victory",Callable($"游戏开始界面","victory"))
	add_child(s)
