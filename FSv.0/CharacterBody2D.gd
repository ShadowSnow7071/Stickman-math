extends CharacterBody2D

var speed = 450
var jump = 600
const gravity = 600

#ataques y vida
var P2_range = false
var P2_cooldown = true
var health = 100
var P2_alive = true

@onready var animP2 = $AnimatedSprite2D

func _physics_process(delta):
	
	velocity.y += gravity*delta
	P1_attack()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		animP2.flip_h = false
	
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
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
			animP2.play("idle2")
		else:
			animP2.play("run2")
	else: 
		animP2.play("jump2")

	#Ataques


func _on_hitbox_p_2_body_entered(body):
	if body.has_method("P1"):
		P2_range = true

func _on_hitbox_p_2_body_exited(body):
	if body.has_method("P1"):
		P2_range = false

func P2():
	pass

func P1_attack():
	if P2_range:
		print("P2 took damage")
		
func attack1():
	pass
