extends CharacterBody2D

var speed = 450
var jump = 600
const gravity = 600

#ataques y vida
var Enemy2_range = false
var Enemy2_cooldown = true
var health = 100
var P2_alive = true
var P2_cooldown = true
var attackin = false

# Nuevas variables para la ecuación
var equation_label : Label
var equation_input : LineEdit
var equation_answer : int
var equation_correct : bool = false


@onready var animP2 = $AnimatedSprite2D
@onready var healthbar = $Healthbar

func _ready():
	healthbar.init_health(health)
	equation_label = $EquationLabel
	equation_input = $EquationInput

func _physics_process(delta):
	
	velocity.y += gravity*delta
	P1_attack()
	attack2()
	
	if health <= 0:
		P2_alive = false
		Global.player1_current_attack = false
		health = 0
		print("player2 has been defeated")
		get_tree().change_scene_to_file("res://Death screen2.tscn")
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		if attackin == false:
			animP2.flip_h = false
	
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		if attackin == false:
			animP2.flip_h = true
	else:
		velocity.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump
	else:
		if Input.is_action_just_released("ui_up"):
			velocity.y += 400
	
	move_and_slide()
	
	if is_on_floor():
		if velocity.x == 0:
			if attackin == false:
				animP2.play("idle2")
		else:
			if attackin == false:
				animP2.play("run2")
	else: 
		if attackin == false:
			animP2.play("jump2")
			
	# Verificar si el player 2 está por debajo de 25% de salud
	if health <= 25 && P2_alive:
	 # Mostrar la ecuación en la pantalla
		equation_label.text = "Solve the equation: 2x + 5 = 11"
		equation_input.visible = true
		equation_input.grab_focus()

func _on_EquationInput_text_entered(text):
	# Verificar si la respuesta es correcta
	equation_answer = int(text)
	if equation_answer == 3:  # 2x + 5 = 11
		equation_correct = true
		print("Correct answer!")
		# Derrotar al oponente
		Global.player1_current_attack = false
		health = 0
		print("player1 has been defeated")
		get_tree().change_scene_to_file("res://Death screen1.tscn")
	else:
		equation_correct = false
		print("Incorrect answer!")

func _on_EquationInput_focus_exited():
	# Ocultar la entrada de texto cuando se pierde el foco
	equation_input.visible = false

#Ataques
func _on_hitbox_p_2_body_entered(body):
	if body.has_method("P1"):
		Enemy2_range = true

func _on_hitbox_p_2_body_exited(body):
	if body.has_method("P1"):
		Enemy2_range = false

func P2():
	pass

func P1_attack():
	if Enemy2_range and Global.player1_current_attack == true:
		if P2_cooldown == true:
			health = health - 5
			$damage2.start()
			P2_cooldown = false
			_set_health(health)
			print("P2 -5 health")
			Global.P1_hits = Global.P1_hits + 1
			Global.scoreP2 = Global.scoreP2 + 5
			
			
func attack2():
	if Input.is_action_just_pressed("P2_Attack"):
		attackin = true
		Global.punch2_ip = true
		Global.player2_current_attack = true
		animP2.play("hit2")
		$damage2.start()
	elif Input.is_action_just_released("P2_Attack"):
		attackin = false
		Global.player2_current_attack = false

func _on_damage_2_timeout():
	P2_cooldown = true

func _set_health(value):
	health = value
	if health <= 0 && P2_alive:
		_die()
	healthbar.health = health

# Funcion del personaje cuando muere
func _die():
	animP2.play("idle")
	
