extends CharacterBody2D
signal op_count(op_num)

@export var move_speed = 300.0
var op_num = 1


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var input_direction = Vector2(
		Input.get_action_strength("temp_right") - Input.get_action_strength("temp_left"),
		Input.get_action_strength("temp_down") - Input.get_action_strength("temp_up")
	)
	
	velocity = input_direction * move_speed
	move_and_slide()

func _process(delta: float) -> void:
	emit_signal("op_count")
