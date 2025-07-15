extends CharacterBody2D
#var
@export var max_health : int = 100
@onready var fireball_scene = preload("res://scens/fireball.tscn") 
var attack_enetr : bool = false
@export var speed: int = 200
@export var gravity: int = 800
@export var jumb_boost: int = -200
var attack_1_timer: bool = false
var jumb_timer: bool = false
var dead : bool = false # dead == die
var target = CharacterBody2D
var attack_2_timer : bool = false
@export var fireballs : int = 5
var gra_no_or_yes : bool = true
#var health  = Globals.health
func die():
	$AnimatedSprite2D.play("die")
	$"sounds/8-bit-video-game-lose-sound-version-1-145828".play()
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://scens/main_menu.tscn")
	
func fix_anim_proplem(F: Vector2, T: Vector2):
	if $AnimatedSprite2D.flip_h == false:
		$AnimatedSprite2D.position = F
	else:
		$AnimatedSprite2D.position = T

func _physics_process(delta: float) -> void:
	#die system
	if dead:return
	if Globals.health <= 0 :
		dead = true
		die()
	if Globals.health > Globals.max_player_health:
		Globals.health = Globals.max_player_health
	print(Globals.health)
	fireballs = Globals.player_fireballs
	Globals.player_pos = global_position
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("left") and not attack_1_timer and not attack_2_timer:
		input_vector.x -= 1
		if jumb_timer == false:
			$AnimatedSprite2D.play("walk")
			if not $"sounds/Sand-step-95801".playing:
				$"sounds/Sand-step-95801".play()
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.position = Vector2(5, -33)


	elif Input.is_action_pressed("right") and not attack_1_timer and not attack_2_timer:
		input_vector.x += 1
		if jumb_timer == false:
			if not $"sounds/Sand-step-95801".playing:
				$"sounds/Sand-step-95801".play()
			$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.position = Vector2(0, -33)

	elif not attack_1_timer and not attack_2_timer :
		if jumb_timer == false:
			if not dead:
				$AnimatedSprite2D.play("Idle")
			fix_anim_proplem(Vector2(13, -33), Vector2(-5, -33))
		if $"sounds/Sand-step-95801".playing:
			$"sounds/Sand-step-95801".stop()

	input_vector = input_vector.normalized()
	velocity.x = input_vector.x * speed
	#attack -----------------
	if Input.is_action_just_pressed("attack_1") and attack_1_timer == false and not attack_2_timer :
		$AnimatedSprite2D.play("attack_1")
		$timers/attack_1_timer.start()
		$timers/attack_1_hit_timer.start()
		$"sounds/Sword-sound-260274".play()
		fix_anim_proplem(Vector2(15, -32), Vector2(-5, -32))
		attack_1_timer = true
	if Input.is_action_pressed("fireball_button") and  Input.is_action_just_pressed('right_click') and attack_2_timer == false and fireballs > 0:
		$AnimatedSprite2D.play("fireball_anim")
		attack_2_timer = true
		fireballs -= 1
		$"sounds/Fire-sound-effects-224089".play()
		Globals.player_fireballs -= 1
		$timers/attack_2_timer.start()
	if not is_on_floor() and gra_no_or_yes:
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	if Input.is_action_just_pressed("jumb") and is_on_floor():
		velocity.y = jumb_boost
		$"sounds/Retro-jump-3-236683".play()
		$AnimatedSprite2D.play("jumb")
		$timers/jumb_timer.start()
		jumb_timer = true
	if jumb_timer:
		fix_anim_proplem(Vector2(18, -33), Vector2(-11, -33))
	#esc button
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	if $AnimatedSprite2D.flip_h == false:
		$attack_1_area/CollisionShape2D.position = Vector2(35, -11)
		$CollisionShape2D.position = Vector2(-1, -3)
		$markers/Marker2D.position = Vector2(30.7,-16.6)
	else:
		$attack_1_area/CollisionShape2D.position = Vector2(-25, -11)
		$CollisionShape2D.position = Vector2(12, -3)
		$markers/Marker2D.position = Vector2(-21.7,-16.6)

	move_and_slide()

func _on_attack_1_timer_timeout() -> void:
	attack_1_timer = false
	$AnimatedSprite2D.position = Vector2(4, -32)

func _on_jumb_timer_timeout() -> void:
	jumb_timer = false

func _on_attack_1_area_body_entered(body: Node2D) -> void:
	if "hit" in body:
		target = body
		attack_enetr = true

func _on_attack_1_area_body_exited(body: Node2D) -> void:
	if "hit" in body:
		target = CharacterBody2D
		attack_enetr = false

func _on_attack_1_hit_timer_timeout() -> void:
	if "hit" in target: target.hit(30)

func _on_attack_2_timer_timeout() -> void:
	attack_2_timer = false
		# إنشاء السهم
	var fireball = fireball_scene.instantiate()
	
	fireball.global_position = $markers/Marker2D.global_position
	
	if $AnimatedSprite2D.flip_h:fireball.dir = "left"
	else:fireball.dir = "right"
	$"../Projctiles".add_child(fireball)


func _on_lader_gra_no() -> void:
	gra_no_or_yes = false


func _on_lader_gra_yes() -> void:
	gra_no_or_yes = true


func _on_level_1_sus() -> void:
	get_tree().change_scene_to_file("res://scens/the_end.tscn")
