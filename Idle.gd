extends State

func enter() -> void:
	parent.animations.play("idle")  # Play idle animation

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return parent.attack_state  # Switch to Attack
	return null
