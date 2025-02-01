extends HBoxContainer

#Audio Slider adjust volume of all audio in the "Master" bus

@onready var label1 = $Label as Label
@onready var label2 = $Label2 as Label
@onready var volume_slider = $HSlider as HSlider

@export_enum("Master") var bus_name : String

var bus_index : int = 0

func _ready() -> void:
	volume_slider.value_changed.connect(on_volume_changed)
	adjust_volume_label()
	set_slider_value()
	
#checks the volume slider and chnges the text to display how much it is at
func adjust_volume_label() -> void:
	label2.text = str(volume_slider.value * 100) + "%"


func on_volume_changed(value : float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	adjust_volume_label() 
	
func set_slider_value() -> void:
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	adjust_volume_label()


func _process(delta: float) -> void:
	pass
