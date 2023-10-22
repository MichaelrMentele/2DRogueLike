extends Node

const SPAWN_RADIUS = 330 # half of width of window

@export var basic_enemy_scene: PackedScene

func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	var ran_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_pos = player.global_position + (ran_dir * SPAWN_RADIUS)

	var enemy = basic_enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = spawn_pos
