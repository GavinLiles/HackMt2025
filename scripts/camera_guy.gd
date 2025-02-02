extends CharacterBody2D


@export var move_speed = 500.0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = input_direction * move_speed
	move_and_slide()
