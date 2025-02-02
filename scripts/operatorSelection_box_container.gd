# For Godot 4:
extends VBoxContainer

@onready var opOptionButton = $Control/Op_OptionButton
@onready var character_image = $Control/Op_TextureRect
@onready var numOfBreaches_label = $numOfBreaches_Label
@onready var health_textureProgressBar = $Health_HBoxContainer/Control/Health_TextureProgressBar
@onready var health_label = $Health_HBoxContainer/Health_Label
@onready var arms_textureProgressBar = $Arms_HBoxContainer/Control/Arms_TextureProgressBar
@onready var arms_label = $Arms_HBoxContainer/Arms_Label
@onready var weapon_image = $Weapon_HBoxContainer/Control/Weapon_TextureRect
@onready var weapon_label = $Weapon_HBoxContainer/WeaponStats_VBoxContainer/Weapon_Label
@onready var stats_container = $Weapon_HBoxContainer/WeaponStats_VBoxContainer/Weapon_Stats_VBoxContainer

const Class_Choices = {
	"Rifleman": {
		"Character": "res://Assets/Characters/survivor-idle_knife_5.png",
		"Image": "res://Assets/Weapons/assaultRifle.png",
		"Health": 100,
		"Weapon": "_Assault Rifle_",
		"NumOfBreaches": 0,
		"Stats": {
			"Damage": 60,
			"Fire_rate": 60,
			"Accuracy": 80,
			"Noise": 70
		},

	},
	"Scout": {
		"Character": "res://Assets/Characters/survivor-idle_handgun_0.png",
		"Image": "res://Assets/Weapons/smg.png",
		"Health": 60,
		"Weapon": "_SMG_",
		"NumOfBreaches": 0,
		"Stats": {
			"Damage": 40,
			"Fire_rate": 90,
			"Accuracy": 50,
			"Noise": 40
		},
	},
	"Breacher": {
		"Character": "res://Assets/Characters/survivor-idle_shotgun_0.png",
		"Image": "res://Assets/Weapons/shotgun.png",
		"Health": 100,
		"Weapon": "_Shotgun_",
		"NumOfBreaches": 0,
		"Stats": {
			"Damage": 95,
			"Fire_rate": 20,
			"Accuracy": 90,
			"Noise": 100
		},
	},
	"Heavy": {
		"Character": "res://Assets/Characters/survivor-idle_rifle_5.png",
		"Image": "res://Assets/Weapons/lmg.png",
		"Health": 150,
		"Weapon": "_LMG_",
		"NumOfBreaches": 0,
		"Stats": {
			"Damage": 65,
			"Fire_rate": 50,
			"Accuracy": 70,
			"Noise": 90
		}
	},
}



func _ready():
	# Clear previous items (if necessary)
	opOptionButton.clear()
	
	# Iterate through all keys in Class_Choices (Rifleman, Scout, etc.)
	for character_class in Class_Choices.keys():
		opOptionButton.add_item(character_class)  # Add class name as an option

	update_character_stats(0)



func _on_op_option_button_item_selected(index: int) -> void:
	update_character_stats(index)


func update_character_stats(index: int) -> void:
	print("Selected:", opOptionButton.get_item_text(index))

	var selected_class = opOptionButton.get_item_text(index)
	var class_data = Class_Choices.get(selected_class, {})

	# Clear previous content first
	for child in stats_container.get_children():
		child.queue_free()

	# Update UI with selected character data
	if class_data.get("Character"):
		# Set visuals
		character_image.texture = load(class_data["Character"]) 
		weapon_image.texture = load(class_data["Image"])  
		weapon_label.text = class_data["Weapon"]

		# Add stats  and get stat total
		var stats = class_data["Stats"]
		var totalStats = 0
		for stat in stats:
			var stat_label = Label.new()
			var formatted_name = stat.replace("_", " ").capitalize() 	# Format stat names nicely (e.g., "Fire_rate" -> "Fire Rate")
			totalStats += stats[stat]
			stat_label.text = "%s: %d" % [formatted_name, stats[stat]]
			stat_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT # Align text to the right
			stats_container.add_child(stat_label) # Add label to the VboxContainer

		# Set Health
		health_label.text = "HEALTH: %d" % [class_data["Health"]]

		# Update Number of Breaches
		numOfBreaches_label.text = "Number of Breaches: %d" % [class_data["NumOfBreaches"]]

		# Set Arms Strength
		arms_label.text = "ARMS STRENGTH: %.1f" % [totalStats / 4.0]
		
