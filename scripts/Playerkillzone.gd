extends Area2D

@onready var player = %Player

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		print("You killed it!")
		self.queue_free()
