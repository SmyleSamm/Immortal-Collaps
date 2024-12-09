extends Area2D

@export var points: int = 1

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var world = body.get_parent()
		if world and world.has_node("GameManager"):
			var gameManager = world.get_node("GameManager")
			gameManager.addKillPoints(1)
		self.get_parent().queue_free()
