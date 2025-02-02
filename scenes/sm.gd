# SpawnManager.gd
extends Node

@export var enemy_scene: PackedScene


func _ready() -> void:
	randomize()  # Initialize the random seed.
	print("SpawnManager _ready triggered")
	spawn_enemies_at_mission_start()

func spawn_enemies_at_mission_start() -> void:
	var room_nodes = get_tree().get_nodes_in_group("rooms")
	for room in room_nodes:
		# Check if this node is an instance of Room.
		if room is Room:
			for i in range(room.enemy_count):
				spawn_enemy_in_room(room)
		else:
			push_warning("Node in 'rooms' group is not a Room: " + str(room))

func spawn_enemy_in_room(room: Node2D) -> void:
	if enemy_scene:
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.position = room.get_random_spawn_position()
		add_child(enemy_instance)
		print("Spawned enemy at: ", enemy_instance.position)
	else:
		print("enemy_scene is not set!")
