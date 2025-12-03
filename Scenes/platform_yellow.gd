extends AnimatableBody2D

var alternate:bool = false

func _on_timer_timeout() -> void:
	self.visible = false
	$CollisionShape2D.disabled = true
	$TimerDisabled.start()
	$TimerBlinking.stop()
	


func _on_detect_zone_body_entered(body: Node2D) -> void:
	$TimerExpiring.start()
	$TimerBlinking.start()
	print("entered")
	$DetectZone.monitoring = false


func _on_timer_blinking_timeout() -> void:
	if not alternate:
		$Sprite2D.modulate = Color.RED
		alternate = true
	else: 
		$Sprite2D.modulate = Color.WHITE
		alternate = false


func _on_timer_disabled_timeout() -> void:
	self.visible = true
	$CollisionShape2D.disabled = false
