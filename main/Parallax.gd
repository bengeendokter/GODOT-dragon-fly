extends ParallaxLayer

class_name Parallax

export(float) var RELATIVE_SPEED = -15
var speed_modifier = 0

func _process(delta) -> void:
	self.motion_offset.x += RELATIVE_SPEED * speed_modifier * delta

func stop_moving() -> void:
	speed_modifier = 0


func start_moving() -> void:
	speed_modifier = 2
