extends CharacterBody2D

var SPEED = 20

func _physics_process(delta: float) -> void:
	position.y = lerp(position.y, position.y - SPEED, 0.4)
