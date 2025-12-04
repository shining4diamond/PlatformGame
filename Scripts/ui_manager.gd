extends CanvasLayer
@onready var leaderboard: GridContainer = $Leaderboard



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%UICoinsCollectedLabel.text = str(Globals.score)

	if(Globals.seconds >= 60):
		Globals.seconds = 0
		Globals.minutes += 1
	else:
		Globals.seconds += 1 * delta
		
	%UITimePassedLabel.text = "%02d:%02d" % [Globals.minutes, Globals.seconds]
	Globals.time = %UITimePassedLabel.text

func _on_leaderboard_pressed() -> void:
	leaderboard.visible = true
	Engine.time_scale = 0
