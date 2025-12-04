extends Node

# Var for global use
var isDead = false

# Var for UI
var score = 0
var deathCount = 0
var coinsCollectedLabel = "0"
var deathCountLabel = "You died 0 times"

# Signals
signal save_signal()

func add_point():
	Globals.score += 1










# Leaderboard features

var player_name:String
var player_list = []
var scores = []
var minutes = 0
var seconds = 0
var time:String

func _ready() -> void:
	SilentWolf.configure({
		"api_key":"58WFXmYIXF3l2ciLREVO7383fN994oJR8nuHa2yY",
		"game_id":"GodotPlatformGameLeaderboard",
		"log_level": 1
	})
	
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/MainPage.tscn"
	})

	
func _physics_process(delta: float) -> void:
	leaderboard()
	
func leaderboard():
	for score in Globals.scores:
		Globals.player_list_append(Globals.player_name)
