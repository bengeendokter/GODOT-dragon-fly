extends ParallaxLayer

export(float) var RELATIVE_SPEED = -15
var SPEED_MODIFIER = 2

func _process(delta) -> void:
	self.motion_offset.x += RELATIVE_SPEED * SPEED_MODIFIER * delta
