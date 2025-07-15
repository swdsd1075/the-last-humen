extends RigidBody2D
var flip = null
var timer = 0
var fliper = null
@export var damege : int = 3
@export var speed = 3.5
func _ready() -> void:
	fliper = flip
func _physics_process(_delta: float) -> void:
	timer += 1
	if fliper == false:
		$ArcherSkeleton.flip_h = true
		position.x += 3.5
	else:
		position.x -= 3.5
		$ArcherSkeleton.flip_h = false
	if timer == 270:queue_free()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method('die'):
		Globals.health -= damege
		#$"Minecraft-Hit(soundEffect)".play()
		visible = false
		await $"Minecraft-Hit(soundEffect)".finished
		queue_free()
