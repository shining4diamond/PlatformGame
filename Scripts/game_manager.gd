extends Node


var score = 0

func add_point():
	score += 1
	print(score)
	$ScoreLabel.text = "Congrats! you've collected " + str(score) + " coins."
