extends Area2D

@export var speed: float = 300.0
var dir: String = "right"

func _process(delta: float) -> void:
	if dir == "left":
		position.x -= speed * delta
		$Charge.flip_h = true
	elif dir == "right":
		position.x += speed * delta
		$Charge.flip_h = false





func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

#make damege for monsters
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if "hit" in body:
		body.hit(50)
		queue_free()
	else:queue_free()
