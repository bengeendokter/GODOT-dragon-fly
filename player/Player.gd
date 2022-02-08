extends Area2D
 
onready var position_up : Vector2 = get_node('../Postitions/UpPosPlayer').position
onready var position_down : Vector2 = get_node('../Postitions/DownPosPlayer').position
onready var tween : Tween = $MovePlayer

signal hit

var is_up := true

func _process(_delta) -> void:
	
	if Input.is_action_pressed("player_action") and !tween.is_active():
		tween.interpolate_property(self
		, "position"
		, null
		, position_down if is_up else position_up
		, 0.30
		, Tween.TRANS_LINEAR
		, Tween.EASE_OUT)
		
		tween.start()


func _on_MovePlayer_tween_completed(_object, _key) -> void:
	tween.remove_all()
	is_up = !is_up


func _on_Player_body_entered(_body):
	hide()
	emit_signal("hit")
