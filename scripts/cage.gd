extends Area2D

signal the_cage_opened

var visible_T : bool = false
var cage_is_open : bool = false
var player_is_enter : bool = false
var T_timer = true
var sus : bool = false


func cage_open():
	$cageclose.visible = false
	$cageopen.visible = true
	$"Iron-bang-119810".play()

func _on_body_entered(_body: Node2D) -> void:
	player_is_enter = true
	visible_T = true

func _on_body_exited(_body: Node2D) -> void:
	player_is_enter = false

func _process(delta: float) -> void:
	if player_is_enter and Input.is_action_just_pressed('use_things') and not cage_is_open:
		cage_open()
		cage_is_open = true
		the_cage_opened.emit()

	# بدء التايمر مرة واحدة
	if visible_T and T_timer and not sus:
		$Timer.start()
		sus = true
#--------------------
	# الظهور التدريجي
	if sus and $"ui/T_open the cage".modulate.a < 1.0:
		$"ui/T_open the cage".modulate.a += delta * 2.5
		$Timer2.start()
	# الاختفاء التدريجي غبي يا جبيتيبي
	if not T_timer and $"ui/T_open the cage".modulate.a > 0.0:
		$"ui/T_open the cage".modulate.a -= delta * 2.5
	if T_timer == false:$"ui/T_open the cage".modulate.a -= delta * 2.5
#--------------------------------- خرابيط
func _on_timer_timeout() -> void:
	T_timer = false
