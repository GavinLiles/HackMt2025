extends OptionButton

@onready var option_windows_size_button = $"." as OptionButton
const WINDOW_MODE_ARRAY : Array[String] = [
	"Fullscreen",
	"Window Mode",
	"Borderless Fullscreen",
	"Borderless Window Mode"
]

func _ready() -> void:
	add_window_mode_items()
	option_windows_size_button.item_selected.connect(on_window_mode_selected)
	 # Replace with function body.

func add_window_mode_items() -> void:
		option_windows_size_button.add_item("Window Mode",0)
		option_windows_size_button.add_item("Fullscreen",1)
		#couldn't get these to work
		#option_windows_size_button.add_item("Borderless Fullscreen",2)
		#option_windows_size_button.add_item("Borderless Window Mode",3)

func on_window_mode_selected(index : int) -> void:
	match index:
		0: #window mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: #fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #borderless fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: #borderless window mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
