extends CharacterBody2D

@export var speed: float = 130.0
@export var jump_velocity: float = -300.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %"game manager"

# Coin label that follows player - find manually
var coin_label

var starting_y: float
var max_height: float = 0

func _ready():
	starting_y = global_position.y
	# Find CoinLabel manually
	coin_label = get_node("CoinLabel")
	update_coin_display()

func _physics_process(delta: float) -> void:
	# Handle gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle unlimited jumping with coin cost (REMOVED is_on_floor() check)
	if Input.is_action_just_pressed("ui_accept"):
		if game_manager.spend_coin():  # Only requirement is having coins
			velocity.y = jump_velocity
			update_coin_display()  # Update label when coins change
			print("Jump! Coins left: ", game_manager.coins)
		else:
			print("Not enough coins to jump!")
	
	# Handle horizontal movement
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle animation")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	velocity.x = direction * speed
	move_and_slide()
	
	# Track height
	var current_height = starting_y - global_position.y
	if current_height > max_height:
		max_height = current_height

# Update the coin label display
func update_coin_display():
	if coin_label and game_manager:
		coin_label.text = "Coins: " + str(game_manager.coins)
	else:
		if not coin_label:
			print("ERROR: CoinLabel not found on player!")
		if not game_manager:
			print("ERROR: Game manager not found!")

# Call this when collecting coins
func on_coin_collected():
	update_coin_display()
