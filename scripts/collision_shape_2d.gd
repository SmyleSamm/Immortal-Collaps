extends CollisionShape2D

func _on_body_entered(body: Node2D):
	print("In range of sign!")
	
func _on_body_exited(body: Node2D):
	print("Out of range!")
