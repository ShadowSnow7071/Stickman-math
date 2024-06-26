extends CharacterBody2D

var speed = 450
var jump = 600
const gravity = 600

#ataques y vida
var Enemy2_range = false
var Enemy2_cooldown = true
var health = 100
var P2_alive = true
var attackin = false
@onready var animP2 = $AnimatedSprite2D

func _physics_process(delta):
	
	velocity.y += gravity*delta
	P1_attack()
	attack2()
	if health <= 0:
		P2_alive = false
		health = 0
		print("player2 has been defeated")
		self.queue_free()
	
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
		if Enemy2_cooldown == true:
			health = health - 10
			$damage2.start()
			Enemy2_cooldown = false
			print("P2 -10 health")

func attack2():
	if Input.is_action_pressed("P2_Attack"):
		attackin = true
		Global.punch2_ip = true
		Global.player2_current_attack = true
		animP2.play("attack2")
		$damage2.start()
	elif Input.is_action_just_released("P2_Attack"):
			attackin = false
			Global.player2_current_attack = false

func _on_damage_2_timeout():
	Enemy2_cooldown = true
