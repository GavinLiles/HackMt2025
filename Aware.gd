extends State

@export var cover_spots: Array[Node2D]  # Cover positions in the room

var timer := 0.0
var max_time := 5.0  # Time before returning to idle
var target_cover: Node2D = null

func enter() -> void:
	parent.animations.play("aware")  # Play alert animation
	timer = 0.0  # Reset timer
	find_best_cover()

func find_best_cover() -> void:
	if cover_spots.is_empty():
		return

	var best_cover = null
	var best_distance = INF

	for cover in cover_spots:
		var distance = parent.global_position.distance_to(cover.global_position)
		if distance < best_distance:
			best_distance = distance
			best_cover = cover

	target_cover = best_cover
	if target_cover:
		parent.move_to(target_cover.global_position)  # Use pathfinding

func process_physics(delta: float) -> State:
	if parent.can_see_player():
		timer = 0.0  # Reset timer if the player is in sight
	else:
		timer += delta
		if timer >= max_time:
			return parent.idle_state  # Return to idle if the player is unseen for too long

	if target_cover and parent.is_at_position(target_cover.global_position):
		parent.take_cover()  # Maybe crouch or prepare

	return null
