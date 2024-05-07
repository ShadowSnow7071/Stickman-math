extends Node

var player1_current_attack = false
var punch1_ip = false
var player2_current_attack = false
var punch2_ip = false
var P1_health = 100
var P2_health = 100

#PUNTOS
var score = 0
var scoreP1 = 0
var scoreP2 = 0

func _process(delta):
	score = scoreP1 + scoreP2

#hits
var P1_hits = 0
var P2_hits = 0

#Vidas globales
var P1_death = false
var P2_death = false
