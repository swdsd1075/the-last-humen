extends Node

var player_pos : Vector2
var gra : int = 800
var health : float = 100.0
var max_player_health : float = 100.0
var player_fireballs : int = 5
func _process(_delta: float) -> void:
	if health <= 0 :health = 0
