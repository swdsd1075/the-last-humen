extends Area2D

signal gra_no
signal gra_yes

var player_eneter : bool = false
var player  : CharacterBody2D
@export var speed : int = 200

func _process(delta: float) -> void:
	if player_eneter and Input.is_action_pressed('up'):
		player.position.y -= speed *delta
	elif player_eneter and Input.is_action_pressed('down'):
		player.position.y += speed *delta

func _on_body_entered(body: Node2D) -> void:
	if "die" in body:
		player_eneter = true
		player = body
		gra_no.emit()

func _on_body_exited(body: Node2D) -> void:
	if "die" in body:
		player_eneter = false
		player = body
		gra_yes.emit()
