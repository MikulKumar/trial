extends Area2D

var game_manager

func _ready():
	# Correct path based on your scene structure
	game_manager = get_node("/root/game/game manager")
	print("Coin ready! Game manager found: ", game_manager != null)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if game_manager:
			game_manager.collect_coin()
			body.update_coin_display()
			print("Coin collected!")
		else:
			print("ERROR: Game manager is null!")
		queue_free()
