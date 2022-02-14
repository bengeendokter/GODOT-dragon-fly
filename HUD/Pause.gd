extends Control

func pause() -> bool:
	var new_pause_state = not is_paused()
	get_tree().paused = new_pause_state
	visible = new_pause_state
	return new_pause_state

func is_paused() -> bool:
	return get_tree().paused
