extends Control

func _ready() -> void:
	$"sounds/Evil-lurks-258066".play()

func _on_button_pressed() -> void:
	$"sounds/Click-buttons-ui-menu-sounds-effects-button-7-203601".play()
	$AnimationPlayer.play("text1")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("yes")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scens/main_menu.tscn")

func _on_button_2_pressed() -> void:
	$"sounds/Click-buttons-ui-menu-sounds-effects-button-7-203601".play()
	$AnimationPlayer.play("text1")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("no")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scens/main_menu.tscn")
