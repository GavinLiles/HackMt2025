extends "res://addons/gd-plug/plug.gd"

func _plugging() -> void:
	# Declare your plugins in here with plug(src, args)
	plug(
		"ninstar/Godot-StateMachineNodes",
		{
			"include": ["addons/state_machine_nodes"],
			"tag": "24.12.31",
		}
	)
	plug(
		"kenyoni-software/godot-addons",
		{
			"dev": true,
			"include": ["addons/icon_explorer"],
			"tag": "hide_private_properties-1.1.2",
		}
	)
	plug(
		"godot-extended-libraries/godot-debug-menu",
		{
			"dev": true, 
			"commit": "3211673efc9d1e41f94bbd74705eaed2d2b8bdd7"
		}
	)
