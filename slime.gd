extends KinematicBody2D

var speed = 50
var gravity = 20

var vel = Vector2()
export var direction = -1
export var detect_cliff = true

func _ready():
	if (direction == 1):
		$AnimatedSprite.flip_h = true
	$checkfloor.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$checkfloor.enabled = detect_cliff
	
	if(detect_cliff):
		set_modulate(Color(1,0.5,1))
	
	vel.x = speed * direction
	

func _physics_process(delta):
	vel.y += gravity
	
	# change direction on wall or cliff edge
	if is_on_wall() or ((not $checkfloor.is_colliding() and detect_cliff) and is_on_floor()):
		direction *= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$checkfloor.position.x = $CollisionShape2D.shape.get_extents().x * direction
		vel.x = speed * direction
	
	vel = move_and_slide(vel, Vector2.UP)
	

func _on_top_checker_body_entered(body):
	body.bounce()
	$AnimatedSprite.play("squashed")
	vel.x = 0
	set_collision_layer_bit(4,false)
	set_collision_mask_bit(0,false)
	$top_checker.set_collision_layer_bit(4,false)
	$top_checker.set_collision_mask_bit(0,false)
	$sides_checker.set_collision_layer_bit(4,false)
	$sides_checker.set_collision_mask_bit(0,false)
	$Timer.start()
	

func _on_sides_checker_body_entered(body):
	body.oof(position.x)

func _on_Timer_timeout():
	queue_free()
