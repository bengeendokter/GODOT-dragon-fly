extends Node
export(PackedScene) var mob_scene

onready var pos_up_mob : Vector2 = $Postitions/UpPosMob.position
onready var pos_down_mob : Vector2 = $Postitions/DownPosMob.position
var mob_positions : Array

var is_music_enabled = true

var upper_mob_speed = -300.0
var lower_mob_speed = -290.0

onready var mobtimer := $Timers/MobTimer

var score := 0

const UPPER_MAX_MOB_SPEED = -480.0
const LOWER_MAX_MOB_SPEED = -465.0
const SPEED_STEP = 20

const MIN_MOB_TIMER_WAIT = 0.6
const TIMER_STEP = 0.10


func _ready():
	mob_positions = [pos_up_mob, pos_down_mob]
	$ParallaxBackground/ParallaxLayer/VulcanoAnimation.play()
	set_score(0)
	$HUD.grab_focus()
	randomize()


func start_game():
	get_tree().call_group("mob", "free")
	set_score(0)
	_reset_speeds()
	$HUD.hide_game_over()
	$HUD.hide_credits_btn()
	$HUD.hide_music_btn()
	$HUD.show_pause_btn()
	$Player.spawn_player()
	$Player.play_idle_animation()
	get_tree().call_group("parallax", "start_moving")
	$Timers/ScoreTimer.start()
	$Timers/MobTimer.start()
	$Timers/DifficultyTimer.start()
	play_music()


func game_over():
	$Timers/ScoreTimer.stop()
	$HUD.show_credits_btn()
	$HUD.show_music_btn()
	$HUD.hide_pause_btn()
	stop_music()
	$Timers/MobTimer.stop()
	$Timers/DifficultyTimer.stop()
	$HUD.show_game_over()
	$HUD.grab_focus()
	get_tree().call_group("parallax", "stop_moving")


func play_music():
	if is_music_enabled:
		$BackgroundMusic.play()


func stop_music():
	$BackgroundMusic.stop()


func set_score(new_score : int) -> void:
	score = new_score
	$HUD.set_score(score)


func move_player():
	if not $PauseLayer/Pause.is_paused():
		$Player.move_player()


func pause():
	if $PauseLayer/Pause.pause():
		$HUD.show_credits_btn()
		$HUD.show_music_btn()
	else:
		$HUD.hide_credits_btn()
		$HUD.hide_music_btn()
		$HUD.hide_credits_window()


func toggle_music(new_state):
	is_music_enabled = not new_state
	if is_music_enabled:
		play_music()
	else:
		stop_music()


func _reset_speeds():
	upper_mob_speed = -300.0
	lower_mob_speed = -290.0
	mobtimer.wait_time = 2.0


func _on_ScoreTimer_timeout():
	set_score(score + 1)


func _on_MobTimer_timeout():
	var mob : RigidBody2D = mob_scene.instance()
	add_child(mob)
	mob.position = mob_positions[randi() % 2]
	
	var velocity = Vector2(rand_range(upper_mob_speed, lower_mob_speed), 0.0)	
	mob.linear_velocity = velocity


func _on_DifficultyTimer_timeout():
	if upper_mob_speed > UPPER_MAX_MOB_SPEED:
		upper_mob_speed = max(upper_mob_speed - SPEED_STEP, UPPER_MAX_MOB_SPEED)

	if lower_mob_speed > LOWER_MAX_MOB_SPEED:
		lower_mob_speed = max(lower_mob_speed - SPEED_STEP, LOWER_MAX_MOB_SPEED)
	
	get_tree().call_group("parallax", "increse_speed", 1)
	
	if mobtimer.wait_time > MIN_MOB_TIMER_WAIT:
		mobtimer.wait_time = max(mobtimer.wait_time - TIMER_STEP, MIN_MOB_TIMER_WAIT)
