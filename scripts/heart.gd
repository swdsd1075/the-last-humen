extends Area2D

@export var value : int = 25

func _on_body_entered(body: Node2D) -> void:
	if "die" in body:
		$"Game-bonus-2-294436".play()
		Globals.health += value
		if Globals.health > Globals.max_player_health:
			Globals.health = Globals.max_player_health
		queue_free()
