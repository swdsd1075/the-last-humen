extends CharacterBody2D
#var
var sound_area : bool = false
@export var jumb_boost : float = -1000.0
var gra : int = Globals.gra + 200
@export var speed : int = 80
var attack_enter : bool = false
var attack_timer : bool = false
var player_enter : bool = false
var Notice_area : bool = false
var health : int = 100
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
#
func _physics_process(delta: float) -> void:
	if kill:return
	$TextureProgressBar.value = health
	if Notice_area and sus and attack_timer == false   :
		$"Sounds/Sand-step-95801".play()
		var dir = (Globals.player_pos - global_position).normalized()
		velocity = dir * speed 
		$AnimatedSprite2D.play("walk")
		#flip the Mushroom
		if Globals.player_pos.x < global_position.x:
			$AnimatedSprite2D.flip_h = false  
			$Attack_area/CollisionShape2D.position = Vector2(-28,15)
			$jump_sysytem/CollisionShape2D.position = Vector2(-6.5,24)
			#
		else:
			$AnimatedSprite2D.flip_h = true
			$Attack_area/CollisionShape2D.position = Vector2(29,15)
			$jump_sysytem/CollisionShape2D.position = Vector2(8,24)
		
	elif attack_timer == false and sus:
		$AnimatedSprite2D.play("idle")
		$"Sounds/Sand-step-95801".stop()
		velocity.x = 0
	# gravity and jumb system
	if not is_on_floor():
		velocity.y += gra * delta
		gra += 900 * delta
	else:
		# القفز
		if jumb_area:
			velocity.y = lerp(velocity.y, jumb_boost, 1)
		else:
			velocity.y = 0
		gra = Globals.gra + 200

	#attack
	if attack_enter and attack_timer == false:
		$AnimatedSprite2D.play("attack")
		$timers/attack_timer.start()
		$timers/sound_timer.start()
		attack_timer = true
		velocity.x = 0
	move_and_slide()
func _on_attack_area_body_entered(body: Node2D) -> void:
	attack_enter = true


func _on_attack_area_body_exited(body: Node2D) -> void:
	attack_enter = false


func _on_notic_area_body_entered(body: Node2D) -> void:
	Notice_area = true
	


func _on_notic_area_body_exited(body: Node2D) -> void:
	Notice_area = false

@export var damege : int = 25

func _on_attack_timer_timeout() -> void:
	attack_timer = false
	Globals.health -= damege
	$"Sounds/Minecraft-Hit(soundEffect)".play()
	$"Sounds/Falling-game-character-352287".play()
	


func _on_jump_sysytem_body_entered(body: Node2D) -> void:
	jumb_area = true


func _on_jump_sysytem_body_exited(body: Node2D) -> void:
	jumb_area = false


func _on_sound_area_body_entered(body: Node2D) -> void:
	sound_area = true


func _on_sound_area_body_exited(body: Node2D) -> void:
	sound_area = false


func _on_sound_timer_timeout() -> void:
	$"Sounds/Falling-game-character-352287".play()
