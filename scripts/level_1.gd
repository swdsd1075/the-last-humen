extends level_0

signal sus 

var start_area : bool = false
var cage_1 : bool = false
var cage_2 : bool = false
var checkpoint_pos : Vector2 = Vector2(-911,-334)
var end_area : bool = false

func _on_kill_area_body_entered(body: Node2D) -> void:
	if "die" in body:
		$"sounds/Minecraft-Hit(soundEffect)".play()
		body.position = Vector2(checkpoint_pos)
		Globals.health -= 8
		if cage_1:$"helpers/bat ( the helper )".position = Vector2(checkpoint_pos)
		if cage_2:$"helpers/bat ( the helper )2".position = Vector2(checkpoint_pos)
	elif "hit" in body:
		body.hit(100)

func _on_cage_the_cage_opened() -> void:
	cage_1 = true


func _on_cage_2_the_cage_opened() -> void:
	cage_2 = true


func _on_one_body_entered(body: Node2D) -> void:
	if "die" in body:checkpoint_pos = $CheckPoints/one/CollisionShape2D.position


func _on_two_body_entered(body: Node2D) -> void:
	if "die" in body:checkpoint_pos = $CheckPoints/two/CollisionShape2D.position


func _on_three_body_entered(body: Node2D) -> void:
	if "die" in body:checkpoint_pos = $CheckPoints/three/CollisionShape2D.position


func _on_the_end_area_body_entered(body: Node2D) -> void:
	await get_tree().create_timer(0.5).timeout
	$ColorRect.visible = true
	$AnimationPlayer.play("sus")
	await $AnimationPlayer.animation_finished
	sus.emit()
	


func _on_the_start_area_body_entered(body: Node2D) -> void:
	if "die" in body and start_area == false:
		start_area = true
		var tween = create_tween()
		tween.tween_property($"User InterFace/text","modulate:a",1,1)
		await get_tree().create_timer(2).timeout
		var tween2 = create_tween()
		tween2.tween_property($"User InterFace/text","modulate:a",0,1)
