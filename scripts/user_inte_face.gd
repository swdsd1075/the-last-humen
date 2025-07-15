extends CanvasLayer

func _process(delta: float) -> void:
	$health_bar/HBoxContainer/TextureProgressBar.max_value = Globals.max_player_health
	if Globals.health > 0:
		$health_bar/HBoxContainer/TextureProgressBar.max_value = Globals.max_player_health
		$health_bar/HBoxContainer/TextureProgressBar.value = Globals.health
	$status/HBoxContainer/MarginContainer/Label.text = str(Globals.player_fireballs)
	if Globals.player_fireballs > 9:
		$status/HBoxContainer/Sprite2D.position = Vector2(255,31)
	else:
		$status/HBoxContainer/Sprite2D.position = Vector2(245,31)
	if Globals.player_fireballs == 0:
		$status/HBoxContainer/MarginContainer/Label.modulate = "ff0000"
	else:
		$status/HBoxContainer/MarginContainer/Label.modulate = "ffffff"
