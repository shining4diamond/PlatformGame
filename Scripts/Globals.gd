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
