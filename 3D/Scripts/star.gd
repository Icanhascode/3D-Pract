extends Area

signal coinCollected

func _ready():
	pass
# Rotation Animation
func _physics_process(delta):
	rotate_y(deg2rad(3))
#Actor Detection
func _on_Star_body_entered(body):
	if body.name == "BallBoi":
		$AnimationPlayer.play("bounce")
		$Timer.start()

func _on_Timer_timeout():
	emit_signal("coinCollected")
	queue_free()
	
