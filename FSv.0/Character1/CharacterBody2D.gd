extends CharacterBody2D

var speed = 450
var jump = 600
const gravity = 600

@onready var animP1 = $AnimatedSprite2D

func _physics_process(delta):
	
	velocity.y += gravity*delta
	
	if Input.is_action_pressed("P1_forward"):
		velocity.x = speed
		animP1.flip_h = false
	
	elif Input.is_action_pressed("P1_back"):
		velocity.x = -speed
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
			animP1.play("idle")
		else:
			animP1.play("run")
	else: 
		animP1.play("jump")
