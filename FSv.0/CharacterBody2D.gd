extends CharacterBody2D

var speed = 450
var jump = 600
const gravity = 600

@onready var animP2 = $AnimatedSprite2D

func _physics_process(delta):
	
	velocity.y += gravity*delta
	
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


