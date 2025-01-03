extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var ray_cast_down = $RayCast2D
@onready var quit_menu: ColorRect = $QuitMenu


const SPEED = 110.0
const JUMP_VELOCITY = -260.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")	
var lastCheckPoint = null
var quit = false
var debug = false
var cin = false
var debugSPEED = 2
var cinSPEED = 0.1

func _ready() -> void:
	ray_cast_down.add_exception(self)
	quit_menu.hide()

func _physics_process(delta: float) -> void:
	if debug:
		move(delta, debugSPEED)
	elif cin:
		move(delta, cinSPEED)
	else:
		normalPhysics(delta)
	devMode()
	
func normalPhysics(delta: float) -> void:
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
	
func move(delta: float, speed: float) -> void:
	if Input.is_action_pressed("move_up"):
		position.y -= SPEED * delta * speed
	if Input.is_action_pressed("move_down"):
		position.y += SPEED * delta * speed
	if Input.is_action_pressed("move_left"):
		position.x -= SPEED * delta * speed
	if Input.is_action_pressed("move_right"):
		position.x += SPEED * delta * speed
	if debug:
		if Input.is_action_just_pressed("interact"):
			if debugSPEED == 5:
				debugSPEED = 0
			debugSPEED += 1
			print(debugSPEED)
	elif cin:
		if Input.is_action_just_pressed("interact"):
			if cinSPEED >= 4.0:
				cinSPEED = 0
			cinSPEED += 0.1
			print(cinSPEED)
			
func devMode() -> void:
	if Input.is_action_just_pressed("debug"):
		var collision_1: CollisionPolygon2D = $CollisionPolygon2D
		var collision_2: CollisionShape2D = $CollisionShape2D
		var collision_3: CollisionShape2D = $CollisionShape2D2
		$AnimatedSprite2D.show()
		
		if debug:
			debug = false
			collision_1.disabled = false
			collision_2.disabled = false
			collision_3.disabled = false
		else:
			debug = true
			cin = false
			collision_1.disabled = true
			collision_2.disabled = true
			collision_3.disabled = true
			animated_sprite.play("jump")
			
	if Input.is_action_just_pressed("cinematic"):
		var collision_1: CollisionPolygon2D = $CollisionPolygon2D
		var collision_2: CollisionShape2D = $CollisionShape2D
		var collision_3: CollisionShape2D = $CollisionShape2D2
		var sprite: AnimatedSprite2D = $AnimatedSprite2D

		if cin:
			cin = false
			collision_1.disabled = false
			collision_2.disabled = false
			collision_3.disabled = false
			sprite.show()
		else:
			cin = true
			debug = false
			collision_1.disabled = true
			collision_2.disabled = true
			collision_3.disabled = true
			sprite.hide()
			
func cinMode() -> void:
	pass
		
func _on_animated_sprite_2d_child_entered_tree(node: Node) -> void:
	pass # Replace with function body.

func teleport(scene_name: String) -> void:
	print("going to ", scene_name)
	if ResourceLoader.exists("res://world/"+scene_name+".tscn"):
		get_tree().change_scene_to_file("res://world/"+scene_name+".tscn")
		return
	if ResourceLoader.exists("res://Menus/"+scene_name+".tscn"):
		get_tree().change_scene_to_file("res://Menus/"+scene_name+".tscn")
		return
	print("Nothing form the above")
	if scene_name == "EXIT":
		get_tree().quit()
		return
	print("World does not exists!")
	get_tree().quit()
