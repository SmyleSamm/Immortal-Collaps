extends Area2D

@export var isVisible: bool = true
@onready var inactiveSprite: Sprite2D = $Inactive
@onready var activeSprite: Sprite2D = $Active
@onready var player = %Player

var active = false

func _ready() -> void:
	if isVisible:
		activeSprite.hide()
		inactiveSprite.show()
	else:
		activeSprite.hide()
		inactiveSprite.hide()
		
func _on_body_entered(body: Node2D) -> void:
	if player != body:
		return
	if player.lastCheckPoint == self:
		return
	player.lastCheckPoint = self
	active = true
	if isVisible:
		inactiveSprite.hide()
		activeSprite.show()
	
func _process(delta: float) -> void:
	if active:
		if player.lastCheckPoint != self:
			active = false
			if isVisible:
				inactiveSprite.show()
				activeSprite.hide()
