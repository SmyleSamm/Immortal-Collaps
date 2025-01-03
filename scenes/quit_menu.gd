extends ColorRect

@onready var no: Button = $HBoxContainer/No
@onready var yes: Button = $HBoxContainer/Yes
@onready var label: Label = $Label

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ESC"):
		print("ESC got pressed")
		if visible:
			hide()
		else:
			show()

func _on_no_pressed() -> void:
	hide()
