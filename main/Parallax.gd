extends ParallaxLayer

class_name Parallax

export(float) var RELATIVE_SPEED = -15
var speed_modifier = 0
var MAX_MODIFIER = 15


func _process(delta) -> void:
	self.motion_offset.x += RELATIVE_SPEED * speed_modifier * delta


func stop_moving() -> void:
	speed_modifier = 0


func start_moving() -> void:
	speed_modifier = 2


func increse_speed(extra_speed : float) -> void:
	speed_modifier += min(extra_speed, MAX_MODIFIER)
