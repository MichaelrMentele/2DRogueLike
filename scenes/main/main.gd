extends Node2D

@export var end_screen_scene: PackedScene


func _ready() -> void:
	print('ready')
	print($%Player.number_bodies_colliding)
	$%Player.health_component.died.connect(on_player_died)


func on_player_died():
	var end_screen_inst = end_screen_scene.instantiate()
	add_child(end_screen_inst)
	end_screen_inst.set_defeat()
