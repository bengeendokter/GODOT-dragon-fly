extends RigidBody2D

func _ready():
	play_idle_animation()


func play_idle_animation():
	$AnimatedSprite.play("idle")


func play_death_animation():
	$AnimatedSprite.play("death")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func on_hit():
	set_sleeping(true)
	play_death_animation()
	yield($AnimatedSprite, "animation_finished")
	hide()
	queue_free()
