extends CharacterBody2D

var attack_timer: bool = true
var attack_area_enter: bool = false
var cage_opened: bool = false
var start_y: float
var desired_height_from_ground = 100.0  
var start_x: float
var stop_the_start_move: bool = false
var speed: int = 100
var notic_area_enter: bool = false
var target: CharacterBody2D
var idle : bool = true
var unvisibel_massge : bool = true
func _ready() -> void:
	start_y = position.y
	start_x = position.x

func _process(delta: float) -> void:
	#ide anim
	if  idle:
		$AnimatedSprite2D.play("idle")
#the start move
	if cage_opened and not stop_the_start_move and unvisibel_massge:
		position.y += 0.8
		position.x += 0.8
		if position.y >= start_y + 25 and position.x >= start_x + 25:
			unvisibel_massge = false
			stop_the_start_move = true
			$Timers/stop_the_start_move.start()
			$massge.visible = true
		
#the move
	var distance = global_position.distance_to(Globals.player_pos)
	if stop_the_start_move and distance > 50.0 and not notic_area_enter:
		var dir = (Globals.player_pos - global_position).normalized()
		position += dir * speed * delta
		
		#flip the helper
		if Globals.player_pos.x < global_position.x:
			$AnimatedSprite2D.flip_h = true  
			$attackArea/CollisionShape2D.position = Vector2(-7,3)
		else:
			$AnimatedSprite2D.flip_h = false 
			$attackArea/CollisionShape2D.position = Vector2(7,3)
#chess the player
	elif notic_area_enter and target and cage_opened: 
		var dir = (target.position - global_position).normalized()
		position += dir * speed * delta
		if attack_area_enter and attack_timer:
			$AnimatedSprite2D.play("attack")
			attack_timer = false
			$Timers/attack_timer.start()
			if target and  "hit" in target:
				target.hit(15)
	move_and_slide()
func _on_bat_cage_1_the_cage_opened() -> void:
	cage_opened = true
	Globals.max_player_health -= 15
	await get_tree().create_timer(2.5).timeout
	#control the massges
	$"User InterFace/masege_the_helath/VBoxContainer/HBoxContainer/Label3".text = str(int(Globals.max_player_health))
	$"User InterFace/masege_the_helath/VBoxContainer/HBoxContainer/Label4".text = str(int(Globals.health))
	var tween_visible = create_tween()
	tween_visible.tween_property($"User InterFace/masege_the_helath","modulate:a",1,1.5)
	await get_tree().create_timer(2).timeout
	var tween_unvisible = create_tween()
	tween_unvisible.tween_property($"User InterFace/masege_the_helath","modulate:a",0,1.5)

func _on_attack_area_body_entered(body: Node2D) -> void:
	if target and "hit" in body and body == target:
		attack_area_enter = true
		idle = false

func _on_attack_area_body_exited(body: Node2D) -> void:
	if "hit" in body:
		attack_area_enter = false
		idle = true
		

func _on_notice_area_body_entered(body: Node2D) -> void:
	if "hit" in body:
		notic_area_enter = true
		target = body

func _on_notice_area_body_exited(body: Node2D) -> void:
	if "hit" in body:
		notic_area_enter = false
		target = null

func _on_attack_timer_timeout() -> void:
	attack_timer = true


func _on_stop_the_start_move_timeout() -> void:
	$massge.visible = false
	unvisibel_massge = true
