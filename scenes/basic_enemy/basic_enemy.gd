extends CharacterBody2D

const MAX_SPEED = 45


func _ready() -> void:
	$Area2D.area_entered.connect(on_area_entered)


func _process(_delta):
	var dir = get_direction_to_player()
	velocity = dir * MAX_SPEED
	move_and_slide()


func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()


func on_area_entered(_other_area: Area2D):
	queue_free()
