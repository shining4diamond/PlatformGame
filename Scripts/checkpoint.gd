extends Area2D

enum State {DEACTIVE, ACTIVE}
@export var current_state:State = State.DEACTIVE

func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedCheckpointData.new()
	print(current_state)
	my_data.state = current_state
	print(my_data.state)
	my_data.position = global_position
	my_data.scene_path = scene_file_path
	
	saved_data.append(my_data)

func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()

func on_load_game(saved_data:SavedData):
	var my_data:SavedCheckpointData = saved_data as SavedCheckpointData
	print(my_data.state)
	if my_data.state == my_data.State.ACTIVE:
		current_state = State.ACTIVE
		active()
	global_position = saved_data.position


func _ready() -> void:
	self.get_node("AnimatedSprite2D").play("Deactive")


func _on_body_entered(body: Node2D) -> void:
	if current_state == State.ACTIVE:
		return
	
	if body.is_in_group("Player"):
		activate()


func activate() -> void:
	current_state = State.ACTIVE
	$AnimationPlayer.play("Activation")
	Globals.save_signal.emit()


func _on_animated_sprite_2d_animation_finished() -> void:
	active()


func active() -> void:
	$AnimationPlayer.play("Active")
