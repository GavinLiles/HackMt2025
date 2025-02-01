class_name UnpressedState
extends StateNode

@onready var main = $"../.."
@onready var button = $"../../UIMain/VBoxContainer/Button"

@onready var pressed = $"../Pressed"


func _enter_state(_old_state: StringName, _state_data: Dictionary) -> void:
	var buttonLabel: Label = get_common_node()
	buttonLabel.text = "Press me!"
	button.pressed.connect(_button_pressed)
	print(name)

func _exit_state(_new_state: StringName, _state_data: Dictionary) -> void:
	button.pressed.disconnect(_button_pressed)

func _button_pressed() -> void:
	enter_state(pressed.name)
