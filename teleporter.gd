extends Area2D

@export var scene_name: String = "tutorialWorld"

var inside = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		inside = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		inside = false

func _process(delta: float) -> void:
	if inside:
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file("res://world/"+scene_name+".tscn")
