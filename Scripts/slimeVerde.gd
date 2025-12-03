extends Node2D

const SPEED = 60

var direction = 1


func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedSlimeData.new()
	my_data.position = global_position
	my_data.scene_path = scene_file_path
	my_data.direction = direction
	
	saved_data.append(my_data)

func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()

func on_load_game(saved_data:SavedData):
	var my_data:SavedSlimeData = saved_data as SavedSlimeData
	global_position = saved_data.position
	direction = saved_data.direction
	if direction == -1:
		$AnimatedSprite2D.flip_h = true

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
	$AnimatedSprite2D.modulate = Color.RED
	set_direction_to_body(body)


func _on_detect_zone_body_exited(body: Node2D) -> void:
	$StateChart.send_event("enemy_out")
	$AnimatedSprite2D.modulate = Color.WHITE
	set_direction_to_body(body)
