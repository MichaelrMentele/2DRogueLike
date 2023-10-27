extends Node

const MAX_RANGE = 150 # this is pixels

@export var sword_ability: PackedScene

@onready var base_wait_time = $Timer.wait_time
var damage = 5


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id != "sword_rate":
		return

	var percent_reduction = current_upgrades["sword_rate"]["quantity"] * 0.1
	$Timer.wait_time = base_wait_time * (1 - percent_reduction)
	$Timer.start()


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	if enemies.size() == 0:
		return

	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)

	var sword_instance = sword_ability.instantiate() as SwordAbility
	var forground_layer = get_tree().get_first_node_in_group("foreground_layer")
	forground_layer.add_child(sword_instance)
	sword_instance.hit_box_component.damage = damage

	sword_instance.global_position = enemies[0].global_position
	# randomize the spawn point in a circle around the enemy
#	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4

	# dir vector
	var enemy_direction = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()
