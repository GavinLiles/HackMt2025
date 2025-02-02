extends Node2D

@export var enemy_scene: PackedScene  # Drag & drop Enemy.tscn in the Inspector
@export var enemy_count: int = 5      # Number of enemies to spawn

func _ready():
	spawn_enemies(enemy_count)

func spawn_enemies(count):
	var spawn_points = get_tree().get_nodes_in_group("EnemySpawnPoints")
	
	if spawn_points.is_empty():
		print("No spawn points found!")
		return
	
	for i in range(count):
		var random_spawn = spawn_points.pick_random()  # Picks a random spawn point
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.global_position = random_spawn.global_position
		add_child(enemy_instance)
		
		# Print statement when an enemy spawns
		print("Enemy spawned at position:", random_spawn.global_position)
