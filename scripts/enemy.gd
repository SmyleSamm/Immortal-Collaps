extends Node2D

@onready var ray_cast_right_down = $RayCastRight
@onready var ray_cast_left_down = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 60

var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!ray_cast_right_down.is_colliding()):
		direction = -1
		animated_sprite.flip_h = true
	if(!ray_cast_left_down.is_colliding()):
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta
