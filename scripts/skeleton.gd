extends CharacterBody2D
#var
var arrow_scene  = preload("res://scens/skeleton_arrow.tscn")
@export var jumb_boost : float = -1000.0
var gra : int = Globals.gra + 200
@export var speed : int = 80
var attack_enter : bool = false
var attack_timer : bool = false
var shot_timer : bool = false
var player_enter : bool = false
var Notice_area : bool = false
var health : int = 100
var kill : bool = false
var sus : bool = true
var jumb_area : bool = false
var sound_area : bool = false
##hit
func hit(damge):
	health -= damge
	$AnimatedSprite2D.modulate = "ff5555"
	await get_tree().create_timer(0.1).timeout
	if health <= 0:
		$AnimatedSprite2D.play("die")
		kill = true
		if sound_area:$sounds/AudioStreamPlayer2D2.play()
		await $AnimatedSprite2D.animation_finished
		queue_free()
	$AnimatedSprite2D.modulate = "ffffff"
func _physics_process(delta: float) -> void:
	if kill:return
	$TextureProgressBar.value = health
	if Notice_area and sus and attack_timer == false   :
		$sounds/AudioStreamPlayer2D3.play()
		var dir = (Globals.player_pos - global_position).normalized()
		velocity = dir * speed 
		$AnimatedSprite2D.play("walk")
		#flip the Mushroom
		if Globals.player_pos.x < global_position.x:
			$AnimatedSprite2D.flip_h = false  
			$attack_area/CollisionShape2D.position = Vector2(-70.5,3.5)
			$jump_sysytem/CollisionShape2D.position = Vector2(-6,5)
			$Marker2D.position = Vector2(-6,2.6)
		else:
			$AnimatedSprite2D.flip_h = true
			$attack_area/CollisionShape2D.position = Vector2(70.5,3.5)
			$jump_sysytem/CollisionShape2D.position = Vector2(6,5)
			$Marker2D.position = Vector2(6,2.6)
	elif attack_timer == false and sus:
		$AnimatedSprite2D.play("idle")
		velocity.x = 0
		$sounds/AudioStreamPlayer2D3.stop()
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
	if attack_enter and attack_timer == false:
		$AnimatedSprite2D.play("attack")
		$timers/attack_timer.start()
		$timers/shot_timer.start()
		attack_timer = true
		velocity.x = 0
	#print(attack_timer, attack_enter)
	move_and_slide()

func _on_notice_area_body_entered(body: Node2D) -> void:
	Notice_area = true


func _on_notice_area_body_exited(body: Node2D) -> void:
	Notice_area = false


func _on_attack_area_body_entered(body: Node2D) -> void:
	attack_enter = true


func _on_attack_area_body_exited(body: Node2D) -> void:
	if "die" in body:attack_enter = false


func _on_jump_sysytem_body_entered(body: Node2D) -> void:
	jumb_area = true


func _on_jump_sysytem_body_exited(body: Node2D) -> void:
	jumb_area = false


func _on_shot_timer_timeout() -> void:
	if attack_enter:
		var arrow = arrow_scene.instantiate()
		
		arrow.global_position = $Marker2D.global_position
		
		#if $AnimatedSprite2D.flip_h:arrow.fliper = false
		#else:arrow.fliper = true
		if $AnimatedSprite2D.flip_h:arrow.flip = false
		else:arrow.flip = true
		if sound_area:
			$sounds/AudioStreamPlayer2D.play()
		$"../../Projctiles".add_child(arrow)


func _on_attack_timer_timeout() -> void:
	attack_timer = false


func _on_sounds_area_body_entered(body: Node2D) -> void:
	if "die" in body:
		sound_area = true


func _on_sounds_area_body_exited(body: Node2D) -> void:
	if "die" in body:
		sound_area = false
