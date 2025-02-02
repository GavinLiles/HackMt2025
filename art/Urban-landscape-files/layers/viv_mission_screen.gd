extends Control

var mainmap = ImageTexture.create_from_image(Image.load_from_file("res://mainmap.png"))
@onready var objective_label = $whiteboard/paper2/Objective
@onready var notes_label = $whiteboard/gpaper/Notes
#var main_menu = preload("res://test.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	
	$whiteboard/TextureRect.texture = mainmap
	
	objective_label.show()
	notes_label.show()

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main_Menu.tscn")
