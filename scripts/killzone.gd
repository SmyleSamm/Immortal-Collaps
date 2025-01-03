extends Area2D

var lastCheckPoint = null

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		lastCheckPoint = body.lastCheckPoint
		if lastCheckPoint:
			body.position.x = lastCheckPoint.position.x
			body.position.y = lastCheckPoint.position.y
		else:
			get_tree().reload_current_scene()
	
