extends Area2D

@export var COLOR: Color = Color.WHITE
@export var scene_name: String = "tutorialWorld"
@onready var label: Label = $Label
@export var player: CharacterBody2D

var inside = false

func _ready() -> void:
	label.add_theme_color_override("font_color", COLOR)
	label.hide()
	
func _on_body_entered(body: Node2D) -> void:
	if body == player:
		inside = true
		label.show()


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		inside = false
		label.hide()
		
func _process(delta: float) -> void:
	if inside and Input.is_action_just_pressed("interact"):
		player.teleport(scene_name)
