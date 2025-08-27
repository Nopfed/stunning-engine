extends Area2D

const SPEED = 8

var health = 3


func _physics_process(delta: float) -> void:
	position.y = lerp(position.y, position.y + SPEED, 0.4)


func takeDamage(damage: int):
	# TODO -> Modulate flash white if hit
	# TODO -> Explode if die
	
	if health - damage < 0: die()
	else: health -= damage


func die(deathReason: String = 'killed'):
	# TODO -> Die if hit player
	# TODO -> if killed by player, add to score, otherwise do nothing
	call_deferred('queue_free')


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('BULLET'):
		takeDamage(body.damage)
		body.die()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$ScreenExitTimer.start(1)


func _on_screen_exit_timer_timeout() -> void:
	die('screen_exit')
