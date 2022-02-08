extends Area2D

onready var position_spawn : Vector2 = get_node('../Postitions/SpawnPosPlayer').position 
onready var position_up : Vector2 = get_node('../Postitions/UpPosPlayer').position
onready var position_down : Vector2 = get_node('../Postitions/DownPosPlayer').position
onready var tween : Tween = $MovePlayer
onready var spawn_tween : Tween = $SpawnPlayer

signal hit

var is_up := true


func spawn_player():
	set_position(position_spawn)

	spawn_tween.interpolate_property(self
	, "position"
	, null
	, position_up
	, 1.50
	, Tween.TRANS_LINEAR
	, Tween.EASE_OUT)
	
	spawn_tween.start()


func _process(_delta) -> void:
	if Input.is_action_pressed("player_action") and !tween.is_active() \
		and !spawn_tween.is_active() and $AnimatedSprite.animation != "death":
		tween.interpolate_property(self
		, "position"
		, null
		, position_down if is_up else position_up
		, 0.30
		, Tween.TRANS_LINEAR
		, Tween.EASE_OUT)
		
		tween.start()


func play_idle_animation():
	$AnimatedSprite.play("idle")


func play_death_animation():
	$AnimatedSprite.play("death")


func stop_animations():
	$AnimatedSprite.stop()


func _on_MovePlayer_tween_completed(_object, _key) -> void:
	tween.remove_all()
	is_up = !is_up


func _on_SpawnPlayer_tween_completed(_object, _key):
	spawn_tween.remove_all()
	is_up = true


func _on_Player_body_entered(body):
	print("ded")
	tween.remove_all()
	spawn_tween.remove_all()
	play_death_animation()
	body.on_hit()
	yield($AnimatedSprite, "animation_finished")
	set_position(position_spawn)
	emit_signal("hit")
	print("yes")

