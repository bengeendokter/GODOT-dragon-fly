extends Node
export(PackedScene) var mob_scene

onready var pos_up_mob : Vector2 = $Postitions/UpPosMob.position
onready var pos_down_mob : Vector2 = $Postitions/DownPosMob.position
var mob_positions : Array

var upper_mob_speed = -300.0
var lower_mob_speed = -290.0

onready var mobtimer := $MobTimer

var score := 0

const UPPER_MAX_MOB_SPEED = -480.0
const LOWER_MAX_MOB_SPEED = -465.0
const SPEED_STEP = 20

const MIN_MOB_TIMER_WAIT = 0.6
const TIMER_STEP = 0.10


func _ready():
	mob_positions = [pos_up_mob, pos_down_mob]
	$ParallaxBackground/ParallaxLayer/VulcanoAnimation.play()
	randomize()
	start_game()


func start_game():
	get_tree().call_group("mob", "free")
	score = 0
	$HUD.hide_game_over()
	$Player.spawn_player()
	$HUD.set_score(score)
	$Player.play_idle_animation()
	get_tree().call_group("parallax", "start_moving")
	$HUD/ScoreTimer.start()
	$Timers/MobTimer.start()
	$BackgroundMusic.play()


func game_over():
	$HUD/ScoreTimer.stop()
	$BackgroundMusic.stop()
	$Timers/MobTimer.stop()
	$HUD.show_game_over()
	$HUD.grab_focus()
	get_tree().call_group("parallax", "stop_moving")


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.set_score(score)


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
	
	if mobtimer.wait_time > MIN_MOB_TIMER_WAIT:
		mobtimer.wait_time = max(mobtimer.wait_time - TIMER_STEP, MIN_MOB_TIMER_WAIT)

