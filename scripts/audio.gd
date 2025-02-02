extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_open_2_pressed() -> void:
	$open.play()


func _on_close_2_pressed() -> void:
	$close.play()


func _on_door_break_2_pressed() -> void:
	$door_break.play()


func _on_glass_break_2_pressed() -> void:
	$glass_break.play()


func _on_knife_2_pressed() -> void:
	$knife.play()


func _on_m_4_ammo_2_pressed() -> void:
	$m4_ammo.play()


func _on_pistol_2_pressed() -> void:
	$pistol.play()


func _on_shotgun_2_pressed() -> void:
	$shotgun.play()
