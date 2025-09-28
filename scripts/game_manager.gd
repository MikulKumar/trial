extends Node

var coins = 5  # Current usable coins
var total_collected = 0  # Score tracking

@onready var player = %"Player"  # Reference to player

# Random coin spawning
var coin_scene = preload("res://scenes/coin.tscn")  # Your coin scene

func _ready():
	spawn_random_coins()

func spawn_random_coins():
	for i in range(200):  # Spawn 15 coins
		var random_x = randi_range(-200,1200)     # Within your game area width
		var random_y = randi_range(-1200, 300)   # Above the water, below the top
		
		var coin = coin_scene.instantiate()
		coin.position = Vector2(random_x, random_y)
		add_child(coin)

func collect_coin():
	print("BEFORE collection - Coins: ", coins)
	coins += 5
	total_collected += 5
	print("AFTER collection - Coins: ", coins)
	# Tell player to update their coin display
	if player:
		player.update_coin_display()
		print("Told player to update display")
	else:
		print("ERROR: Player reference is null!")

func spend_coin():
	if coins > 0:
		coins -= 1
		# Tell player to update their coin display
		if player:
			player.update_coin_display()
		return true
	return false
