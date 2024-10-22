extends TextureRect

signal game_start

func victory():
	$CenterContainer/Control/Label.text = "恭喜胜利"
	show()
	
func death():
	$CenterContainer/Control/Label.text = "胜败乃兵家常事"
	show()
	
func _on_start_pressed() -> void:
	hide()
	emit_signal("game_start")


func _on_exit_pressed() -> void:
	get_tree().quit()
