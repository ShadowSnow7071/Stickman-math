extends ProgressBar

@export var P1: CharacterBody2D

func _ready():
	update()

func update():
	value = 3 * 100 / 3
