extends CanvasLayer

var coins = 0

func _ready():
	$coins.text=String(coins)
	
func _physics_process(delta):
	if coins == 10:
		get_tree().change_scene("res://World.tscn")

func _on_coins_collected():
	coins = coins + 1
	_ready()
