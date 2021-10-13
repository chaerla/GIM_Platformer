extends KinematicBody2D

var score : int = 0
var coins : int = 0
var speed : int = 200
var jumpForce : int = 600
var gravity : int = 20

var is_hit = false

var vel : Vector2 = Vector2()
onready var sprite : AnimatedSprite = get_node("Sprite")

func _physics_process(delta):
	# initialize y velocity
	vel.y += gravity
	
	# movement along x axis inputs
	if(is_hit):
		$Sprite.animation = "hit"
	elif Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		vel.x = speed
		$Sprite.flip_h = false
		$Sprite.animation = "walk1"
	elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		vel.x = -speed
		$Sprite.flip_h = true
		$Sprite.animation = "walk1"
	else:
		$Sprite.animation = "idle"
	
	if(not is_on_floor() and not is_hit):
		$Sprite.animation = "jump"
	
	# movement along y axis (jumps)
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_hit:
		vel.y -= jumpForce
	
	# apply the velocity
	vel = move_and_slide(vel,Vector2.UP)
	
	# linear interpolation of velocity on x axis
	vel.x = lerp(vel.x,0,0.4)
	

func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://World.tscn")
	coins = 0
	

func bounce():
	vel.y -= jumpForce * 0.65
	

func oof(var enemyx):
	set_modulate(Color(1,0,0,0.3))
	is_hit = true
	
	vel.y -= jumpForce * 0.8
	
	if (position.x < enemyx):
		vel.x = -800
	else:
		vel.x = 800
	
	$Timer.start()
	

func _on_Timer_timeout():
	get_tree().change_scene("res://World.tscn")
	
