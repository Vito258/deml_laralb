extends TileMapLayer

signal victory
signal failed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("victory")
		queue_free()


func _on_主角_death() -> void:
	emit_signal("failed")
	queue_free()
