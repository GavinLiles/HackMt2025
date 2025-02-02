# Room.gd
extends Node2D
class_name Room  # This allows you to use "Room" as a type.

@export var spawn_area: Rect2 = Rect2(Vector2.ZERO, Vector2(400, 300))
@export var enemy_count: int = 5

func _ready() -> void:
	add_to_group("rooms")

func get_random_spawn_position() -> Vector2:
	var local_x = randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x)
	var local_y = randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
	return global_position + Vector2(local_x, local_y)
