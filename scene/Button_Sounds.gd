extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_start_pressed() -> void:
	$Start_Pressed.play(); #Start button sound will Play when pressed
	await get_tree().create_timer(1.3).timeout
	get_tree().change_scene_to_file("res://scene/viv_mission_screen.tscn")

func _on_options_pressed() -> void:
	$Options_Pressed.play(); #Options button sound will Play when pressed


func _on_credits_pressed() -> void:
	$Credits_Pressed.play(); #Credits button sound will Play when pressed
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scene/Credits.tscn") #Switch to Credits screen

func _on_quit_pressed() -> void:
	get_tree().quit() #Game will close
