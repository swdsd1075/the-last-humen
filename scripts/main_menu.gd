extends Control

var button_presss : bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("use_things") and button_presss:
		get_tree().change_scene_to_file("res://scens/level_1.tscn")

func _on_button_pressed() -> void:
	$"Sounds/Click-buttons-ui-menu-sounds-effects-button-7-203601".play()
	button_presss = true
	$"Sounds/Evil-lurks-258066".play()
	$CanvasLayer/Buttons.visible = false
	$CanvasLayer/Title.visible = false
	$CanvasLayer/cridets.visible = false
	$ColorRect.visible = true
	$"CanvasLayer/Zanga logo".visible = false
	$CanvasLayer/story.visible = true
	$CanvasLayer/skip.visible = true
	$AnimationPlayer.play('talking')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scens/level_1.tscn")


func _on_button_2_pressed() -> void:
	$"Sounds/Click-buttons-ui-menu-sounds-effects-button-7-203601".play()
	get_tree().quit()
