extends CanvasLayer

var seconds = 0
var minutes = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%UICoinsCollectedLabel.text = str(Globals.score)

	if(seconds >= 60):
		seconds = 0
		minutes += 1
		print(minutes)
	else:
		seconds += 1 * delta
		
	%UITimePassedLabel.text = "%02d:%02d" % [minutes, seconds]
