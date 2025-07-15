extends CharacterBody2D
#var
@export var jumb_boost : float = -1000.0
var gra : int = Globals.gra + 200
@export var speed : int = 80
var attack_enter : bool = false
var attack_timer : bool = false
var player_enter : bool = false
var Notice_area : bool = false
var health : int = 200
var kill : bool = false
var sus : bool = true
var jumb_area : bool = false
##hit
func hit(damge):
	health -= damge
	$AnimatedSprite2D.modulate = "ff5555"
	await get_tree().create_timer(0.1).timeout
	if health <= 0:
		$AnimatedSprite2D.play("die")
		kill = true
		await $AnimatedSprite2D.animation_finished
		queue_free()
	$AnimatedSprite2D.modulate = "ffffff"
