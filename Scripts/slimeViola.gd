extends CharacterBody2D

const SPEED = 60
const JUMP_VELOCITY = -200
var direction = 1
var jump = "none"
var berserkMode = false
var observingMode = false
var body_path = ""


func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedSlimeData.new()
	my_data.position = global_position
	my_data.scene_path = scene_file_path
	my_data.direction = direction
	my_data.berserkMode = berserkMode
	
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
	berserkMode = saved_data.berserkMode
	$DetectZone.monitoring = false
	$Timer.start()

func _on_timer_timeout() -> void:
	$DetectZone.monitoring = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if observingMode:
		set_direction_to_body(body_path)
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if $RayCastRight.is_colliding():
		# Handle jump.
		if is_on_floor():
			if berserkMode:
				velocity.y = JUMP_VELOCITY
			else:
				direction = -1
				$AnimatedSprite2D.flip_h = true

	if $RayCastLeft.is_colliding():
		# Handle jump.
		if is_on_floor():
			if berserkMode:
				velocity.y = JUMP_VELOCITY
			else:
				direction = 1
				$AnimatedSprite2D.flip_h = false

	velocity.x = direction * SPEED
	move_and_slide()

func set_direction_to_body(body_path: String) -> void:
	#sets direction to body position
	if(position.x>get_node(body_path).position.x):
		direction = -1
		$AnimatedSprite2D.flip_h = true
	else:
		direction = 1
		$AnimatedSprite2D.flip_h = false


func _on_detect_zone_body_entered(body: Node2D) -> void:
	$StateChart.send_event("enemy_entered")
	body_path = body.get_path()

func _on_detect_zone_body_exited(body: Node2D) -> void:
	$StateChart.send_event("enemy_out")


func _on_observing_state_entered() -> void:
	observingMode = true;

func _on_observing_state_exited() -> void:
	observingMode = false;


func _on_berserk_state_entered() -> void:
	berserkMode = true
	$AnimatedSprite2D.modulate = Color.RED

func _on_berserk_state_exited() -> void:
	berserkMode = false
	$AnimatedSprite2D.modulate = Color.WHITE
