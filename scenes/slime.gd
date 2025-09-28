extends Node2D

@onready var ray_cast_right = $RayCastright
@onready var ray_cast_left = $RayCastleft
@onready var animated_sprite =$AnimatedSprite2D
const speed = 60
var direction = 1

func _process(delta: float) -> void:
	# When hitting a wall, turn AWAY from it
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true  # Turn left when hitting right wall
	if ray_cast_left.is_colliding():
		animated_sprite.flip_h = false
		direction = 1   # Turn right when hitting left wall
	
	position.x += direction * speed * delta
