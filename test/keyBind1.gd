extends HBoxContainer

@onready var label1 = $Label as Label
@onready var button1 = $Button as Button

@export var action_name : String = "move_left"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_unhandled_key_input(false)
	set_action_name()
	
func set_action_name() -> void:
	label1.text = "Unassigned"
	
	match action_name:
		"move_left":
			label1.text = "Move Left"
		"move_up":
			label1.text = "Move Up"
		"move_right":
			label1.text = "Move Right"
		"move_down":
			label1.text = "Move Down"
	
func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	button1.text = "%s" % action_keycode

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		button1.text = "Enter a key"
		set_process_unhandled_key_input(toggled_on)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button1.toggle_mode = false
				i.set_process_unhandled_key_input(false)
		
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button1.toggle_mode = true
				i.set_process_unhandled_key_input(false)
				
		set_text_for_key()
	
func _unhandled_key_input(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
