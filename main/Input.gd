extends Node

signal move_player
signal pause

func _input(event) -> void:
	if event.is_action_pressed("player_action"):
		emit_signal("move_player")
	if event.is_action_pressed("pause"):
		emit_signal("pause")
