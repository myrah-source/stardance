extends Node

var score = 0

@onready var score_label = $"score label"

func add_point():
	score += 1
	print(score)
	score_label.text = "You collected " + str(score) + " coins!!"
	
