extends CharacterBody2D

var SPEED = 20
var damage = 1

func _physics_process(delta: float) -> void:
	position.y = lerp(position.y, position.y - SPEED, 0.4)


func die():
	call_deferred('queue_free')
