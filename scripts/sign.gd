extends StaticBody2D

@export var TEXT: String = "Dev forgot the text ._. Please report!"
@export var COLOR: Color = Color.WHITE

@onready var label: Label = $Label

var playerInside = false

func _ready() -> void:
	label.hide()
	label.add_theme_color_override("font_color", COLOR)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		label.text = "Press 'E' to read"
		label.show()
		self.playerInside = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		label.hide()
		self.playerInside = false

func _process(delta: float) -> void:
	if self.playerInside:
		if Input.is_action_pressed("interact"):
			label.text = TEXT
