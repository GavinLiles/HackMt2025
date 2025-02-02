extends Node
class_name State  # Allows other scripts to extend this

var parent: Enemy  # Reference to the player#

func enter() -> void:
	pass  # Called when the state starts

func exit() -> void:
	pass  # Called when the state ends

func process_input(event: InputEvent) -> State:
	return null  # Handle input; return new state if needed

func process_physics(delta: float) -> State:
	return null  # Handle physics updates

func process_frame(delta: float) -> State:
	return null  # Handle per-frame updates
