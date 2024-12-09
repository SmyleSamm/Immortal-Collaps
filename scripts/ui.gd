extends Node2D

@onready var camera_2d: Camera2D = %Camera2D
@onready var label: Label = $Label

func _process(delta: float) -> void:
	label.global_position = camera_2d.global_position
