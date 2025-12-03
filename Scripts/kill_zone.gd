extends Area2D

@onready var saver_loader: Node = %SaverLoader

@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	
	# The next 2 line of code are needed to fix SaverLoader node visibility to Slimes.
	if saver_loader == null:
		saver_loader = get_node("/root/Game/Utilities/SaverLoader")
	
	if not Globals.isDead:
		Globals.isDead = true
		Globals.deathCount += 1
		$AnimationPlayer.play("HurtSound")
		Engine.time_scale = 0.5
		timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	loadCheckpoint()
	Globals.isDead = false

func _on_invicible_timeout() -> void:
	Globals.isDead = false



func loadCheckpoint() -> void:
	var saved_game:SavedGame = load("user://savegame.tres")
	saved_game.deaths = Globals.deathCount
	ResourceSaver.save(saved_game, "user://savegame.tres")
	
	saver_loader.load_game()
	
