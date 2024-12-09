extends Area2D

@export var isVisible: bool = true
@onready var inactiveSprite: Sprite2D = $Inactive
@onready var activeSprite: Sprite2D = $Active

var player = null
var active = false

func _ready() -> void:
	if isVisible:
		activeSprite.hide()
		inactiveSprite.show()
	else:
		activeSprite.hide()
		inactiveSprite.hide()
		
func _on_body_entered(body: Node2D) -> void:
	player = body
	if player.name != "Player":
		return
	if player.lastCheckPoint == self:
		return
	player.lastCheckPoint = self
	active = true
	if isVisible:
		inactiveSprite.hide()
		activeSprite.show()
	
func _process(delta: float) -> void:
	if active: # -> player != null because the player already entered the body
		if player.lastCheckPoint != self:
			active = false
			if isVisible:
				inactiveSprite.show()
				activeSprite.hide()
