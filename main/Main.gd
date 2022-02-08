extends Node

var score := 0

func _ready():
	$HUD.set_score(score)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.set_score(score)
