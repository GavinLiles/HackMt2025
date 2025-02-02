extends Camera2D

@export var MAX_IN = Vector2(20,20)

@export var MAX_OUT = Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Zoom_in()
	print(zoom)


func Zoom_in():
	if Input.is_action_just_pressed("scroll_up"):
		if zoom < MAX_IN:
			zoom += Vector2(1,1)

	if Input.is_action_just_pressed("scroll_down"):
		if zoom > MAX_OUT:
			zoom -= Vector2(1,1)
