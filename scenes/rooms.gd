# Room.gd
extends Node2D

@export var spawn_manager: Node  # Change from NodePath to Node
var has_spawned: bool = false     # Prevents multiple spawns

func _ready():
	if spawn_manager == null:
		spawn_manager = $SpawnManager  # Assign the actual node reference

# Called when the player enters the room
func _on_Area2D_body_entered(body):
	if body.name == "Player" and not has_spawned:
		spawn_enemies()
		has_spawned = true  # Prevents re-spawning when re-entering the room

func spawn_enemies():
	if spawn_manager and spawn_manager.has_method("spawn_enemies"):
		spawn_manager.spawn_enemies()
