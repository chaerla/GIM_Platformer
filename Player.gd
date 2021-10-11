extends KinematicBody2D

var score : int = 0
var coins : int = 0
var speed : int = 200
var jumpForce : int = 600
var gravity : int = 1000


var vel : Vector2 = Vector2()
onready var sprite : AnimatedSprite = get_node("Sprite")

func _physics_process(delta):
	# initialize x velocity
	vel.x=0
	
	# movement along x axis inputs
	if Input.is_action_pressed("move_right"):
		vel.x+=speed
	if Input.is_action_pressed("move_left"):
		vel.x-=speed
	
	# apply the velocity
	vel = move_and_slide(vel,Vector2.UP)
	if (vel.x!=0 and is_on_floor()):
		$Sprite.animation = "walk1"
	elif (!vel.x):
		$Sprite.animation = "idle"
	else:
		$Sprite.animation = "jump"
		
	# initialize y velocity
	vel.y+=gravity*delta
	
	# movement along y axis (jumps)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		vel.y-=jumpForce

	if (vel.y<0):
		$Sprite.animation = "jump"
	elif (vel.x!=0):
		$Sprite.animation = "walk1"
	elif (!vel.x):
		$Sprite.animation = "idle"
	
	# changing player's direction
	if vel.x < 0:
		sprite.flip_h=true
	if vel.x > 0:
		sprite.flip_h=false
	
		
func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://World.tscn")
	coins = 0

