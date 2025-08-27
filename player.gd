extends CharacterBody2D

@onready var bulletScene = preload("res://bullet.tscn")

const SPEED: float = 10.0
const SHOOT_COOLDOWN: float = 0.3
const SHOOT_POSITION: Vector2 = Vector2(0, -24)
const SIZE = 64

var canShoot: bool
var screenWidth
var screenHeight
var damage: int = 1

var topWall = 100

# TODO -> Add healthbar
# TODO -> Take damage if hit by enemy
# TODO -> Move slower if took damage/lost a wing


func _ready() -> void:
	screenWidth = get_viewport().get_visible_rect().size.x
	screenHeight = get_viewport().get_visible_rect().size.y
	$ShootTimer.start(SHOOT_COOLDOWN)


func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if canShoot:
			canShoot = false
			shoot()


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('left'):
		position.x = lerp(position.x, position.x - SPEED, 0.4)
	elif Input.is_action_pressed('right'):
		position.x = lerp(position.x, position.x + SPEED, 0.4)
	
	if Input.is_action_pressed('up'):
		position.y = lerp(position.y, position.y - SPEED, 0.4)
	elif Input.is_action_pressed('down'):
		position.y = lerp(position.y, position.y + SPEED, 0.4)
	
	if position.x < SIZE: position.x = SIZE
	if position.x > screenWidth - SIZE: position.x = screenWidth - SIZE
	if position.y < topWall: position.y = topWall
	if position.y > screenHeight - SIZE: position.y = screenHeight - SIZE


func shoot():
	# TODO -> fix irregular double shoots
	# TODO -> Add shoot sound
	
	var newBullet = bulletScene.instantiate()
	
	newBullet.position = position + SHOOT_POSITION
	newBullet.damage = damage
	
	get_parent().call_deferred("add_child", newBullet)


func _on_shoot_timer_timeout() -> void:
	canShoot = true
	#$ShootTimer.start()
