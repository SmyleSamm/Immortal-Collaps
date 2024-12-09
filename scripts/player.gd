extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var ray_cast_down = $RayCast2D

const SPEED = 100.0
const JUMP_VELOCITY = -250.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")	
var lastCheckPoint = null

func _ready() -> void:
	ray_cast_down.add_exception(self)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#Handle going through platforms
	if ray_cast_down.is_colliding():
		var collider = ray_cast_down.get_collider()
		if collider.is_in_group("Platforms") and Input.is_action_pressed("move_down"):
			position.y += 1
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#get the direction
	var direction := Input.get_axis("move_left", "move_right")
	
	#Add animation based on if the player is on a floor or not
	if is_on_floor():
		#Add animation if player is idle or moving
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
		#change Player facing direction
		if(direction > 0):
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	

func _on_animated_sprite_2d_child_entered_tree(node: Node) -> void:
	pass # Replace with function body.
