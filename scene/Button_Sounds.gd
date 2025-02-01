extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	$Start_Pressed.play(); #Start button sound will Play when pressed


func _on_options_pressed() -> void:
	$Options_Pressed.play(); #Options button sound will Play when pressed


func _on_credits_pressed() -> void:
	$Credits_Pressed.play(); #Credits button sound will Play when pressed
	get_tree().change_scene_to_file("res://Credits.tscn") #Switch to Credits screen

func _on_quit_pressed() -> void:
	get_tree().quit() #Game will close
