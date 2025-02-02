# SpawnManager.gd
extends Node2D

# Drag and drop your enemy scene here in the inspector
@export var enemy_scene: PackedScene
@export var spawn_count: int = 3  # Number of enemies to spawn

func _ready():
	spawn_enemies()

func spawn_enemies():
	var spawn_points = get_children().filter(func(child): return child is Marker2D)
	
	for i in range(spawn_count):
		if spawn_points.size() == 0:
			break  # No spawn points available
		
		var spawn_point = spawn_points[randi() % spawn_points.size()]
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.global_position = spawn_point.global_position
		get_tree().current_scene.add_child(enemy_instance)
