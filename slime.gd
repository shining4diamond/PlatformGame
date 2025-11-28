extends Node2D

const SPEED = 60

var direction = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $RayCastRight.is_colliding():
		direction = -1
		$AnimatedSprite2D.flip_h = true
	if $RayCastLeft.is_colliding():
		direction = 1
		$AnimatedSprite2D.flip_h = false

	position.x += direction * SPEED * delta

func set_direction_to_body(body: Node2D) -> void:
	#sets direction to body position
	if(position.x>body.position.x):
		direction = -1
		$AnimatedSprite2D.flip_h = true
	else:
		direction = 1
		$AnimatedSprite2D.flip_h = false
	
func _on_detect_zone_body_entered(body: Node2D) -> void:
	$StateChart.send_event("enemy_entered")
	
	set_direction_to_body(body)


func _on_detect_zone_body_exited(body: Node2D) -> void:
	$StateChart.send_event("enemy_out")
	
	set_direction_to_body(body)
