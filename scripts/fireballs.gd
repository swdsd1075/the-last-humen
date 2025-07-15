extends Area2D

@export var fireballs_get : int = 3

func _on_body_entered(body: Node2D) -> void:
	if "die" in body:
		$"Game-bonus-2-294436".play()
		Globals.player_fireballs += fireballs_get
		queue_free()
