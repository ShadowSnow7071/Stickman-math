extends Node2D
#variables scorelabel
@onready var ScoreBox = $Control/ScoreBox
@onready var ScoreBackground=$Control/ScoreBox/ScoreBackground
@onready var Box2 =$Control/ScoreBox/ScoreBackground/Box2
@onready var ScoreText = $Control/ScoreBox/ScoreBackground/Box2/ScoreText

@onready var P1h=$ControlHits/MarginContainer/Label/Label
@onready var P2h=$ControlHits/MarginContainer2/Label/Label

func _on_node_2d_ready():
	Global.scoreP1 = 0
	Global.scoreP2 = 0
	Global.P1_hits = 0
	Global.P2_hits = 0
	
func _process(delta):
	ScoreText.text = str(Global.score)
	P1h.text = str(Global.P1_hits)
	P2h.text = str(Global.P2_hits)

func _on_score_time_timeout():
	pass # Replace with function body.
	
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Menu.tscn")

