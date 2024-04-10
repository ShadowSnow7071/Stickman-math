extends ProgressBar

@export var P1: CharacterBody2D

func _ready():
	update()

func update():
	value = P1.currentHealth * 100 / P1.maxHealth
