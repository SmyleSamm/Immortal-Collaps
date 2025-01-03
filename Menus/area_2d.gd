extends Button

@export var scene_name: String = "tutorialWorld"

func _on_button_down() -> void:
	print("going to ", scene_name)
	print(get_groups())
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
