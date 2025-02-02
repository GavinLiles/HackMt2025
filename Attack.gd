extends State

@export var cover_spots: Array[Node2D]

var target_cover: Node2D = null

func enter() -> void:
	parent.animations.play("attack")
	decide_action()

func decide_action() -> void:
	if has_nearby_cover():
		parent.move_to(target_cover.global_position)  # Move to cover
	else:
		parent.attack_from_position()  # Engage from current position

func has_nearby_cover() -> bool:
	var best_distance = INF

	for cover in cover_spots:
		var distance = parent.global_position.distance_to(cover.global_position)
		if distance < 300:  # Define max cover distance
			if distance < best_distance:
				best_distance = distance
				target_cover = cover

	return target_cover != null

func process_physics(delta: float) -> State:
	if target_cover and parent.is_at_position(target_cover.global_position):
		return parent.aware_state  # Switch to Aware state when in cover

	return null
