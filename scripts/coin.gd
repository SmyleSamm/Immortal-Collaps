extends Area2D

@onready var game_manager = %GameManager
@onready var player = %Player

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		game_manager.add_point()
		queue_free()
