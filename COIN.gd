extends Area2D

signal coins_collected


func _on_COIN_body_entered(body):
	$AnimationPlayer.play("New Anim")
	emit_signal("coins_collected")


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
