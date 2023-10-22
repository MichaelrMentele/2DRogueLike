extends CharacterBody2D

const MAX_SPEED = 75

func _ready() -> void:
	pass


func _process(delta):
	var dir = get_direction_to_player()
	velocity = dir * MAX_SPEED
	move_and_slide()


func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
