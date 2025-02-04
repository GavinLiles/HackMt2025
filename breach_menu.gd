extends MarginContainer

signal bt_score(num)
var num

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_open_pressed():
	num = 0
	emit_signal("bt_score")
	return num


func _on_close_pressed():
	num = -1
	emit_signal("bt_score")
	


func _on_soft_breach_pressed():
	num = 1
	emit_signal("bt_score")


func _on_hard_breach_pressed() -> int:
	num = 2
	emit_signal("bt_score")
	return num


func _on_bt_score(num: Variant) -> void:
	pass # Replace with function body.
