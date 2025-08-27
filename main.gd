extends Node2D

@onready var enemyScene = preload("res://enemy.tscn")

const OFFSCREEN_TOP_POSITION = -50
const SCREEN_WIDTH_BOUNDARY = 50

var screenWidth


func _ready() -> void:
	screenWidth = get_viewport().get_visible_rect().size.x


func spawnEnemy():
	var newEnemy = enemyScene.instantiate()
	var randomWidthPosition = \
		randi_range(
			0 + SCREEN_WIDTH_BOUNDARY,
			screenWidth - SCREEN_WIDTH_BOUNDARY
		)
	
	newEnemy.position = Vector2(randomWidthPosition, OFFSCREEN_TOP_POSITION)
	
	call_deferred('add_child', newEnemy)


func _on_enemy_spawn_timer_timeout() -> void:
	spawnEnemy()
	var randomTime: float = randf_range(0, 2)
	$EnemySpawnTimer.start(randomTime)
