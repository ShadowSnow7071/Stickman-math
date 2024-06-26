extends CharacterBody2D
# fisicas de movimiento
var speed = 450
var jump = 600
const gravity = 600

#ataques y vida
var Enemy_range = false
var Enemy_cooldown = true
var health = 100
var P1_alive = true

var attackin = false
@onready var animP1 = $AnimatedSprite2D

#Movimientos 
func _physics_process(delta):
	
	velocity.y += gravity*delta
	P2_attack()
	attackP1()
	
	if health <= 0:
		P1_alive = false
		health = 0
		print("player1 has been defeated")
		self.queue_free()
		
	if Input.is_action_pressed("P1_forward"):
		velocity.x = speed
		if attackin == false:
			animP1.flip_h = false
	
	elif Input.is_action_pressed("P1_back"):
		velocity.x = -speed
		if attackin == false:
			animP1.flip_h = true
	else:
		velocity.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("P1_jump"):
			velocity.y = -jump
	else:
		if Input.is_action_just_released("P1_jump"):
			velocity.y += 400

	move_and_slide()
		
	if is_on_floor():
		if velocity.x == 0:
			if attackin == false:
				animP1.play("idle")
		else:
			if attackin == false:
				animP1.play("run")
	else: 
		if attackin == false:
			animP1.play("jump")

#Ataques
func _on_hitbox_p_1_body_entered(body):
	if body.has_method("P2"):
		Enemy_range = true

func _on_hitbox_p_1_body_exited(body):
	if body.has_method("P2"):
		Enemy_range = false
		
func P1():
	pass

func P2_attack():
	if Enemy_range and Global.player2_current_attack == true:
		if Enemy_cooldown == true:
			health = health - 10
			$damage.start()
			Enemy_cooldown = false
			print("P1 -10 health")
		
func attackP1():
	if Input.is_action_pressed("P1_Attack"):
		Global.punch1_ip = true
		attackin = true
		Global.player1_current_attack = true
		animP1.play("attack")
		$damage.start()
	elif Input.is_action_just_released("P1_Attack"):
			attackin = false
			Global.player1_current_attack = false


func _on_damage_timeout():
	Enemy_cooldown = true
