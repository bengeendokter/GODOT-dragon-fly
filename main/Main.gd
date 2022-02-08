extends Node

var score := 0

func _ready():
	$HUD.set_score(score)
	$Player.play_idle_animation()
	get_tree().call_group("parallax", "start_moving")
	$ParallaxBackground/ParallaxLayer/VulcanoAnimation.play()
	$HUD/ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.set_score(score)
