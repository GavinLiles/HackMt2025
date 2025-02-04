extends MarginContainer

var player_health
var MAX_PLAYER_HEALTH
var stamina

var tex_paths = [
	"res://Art/000_body.png",
	"res://Art/025_body.png",
	"res://Art/050_body.png",
	"res://Art/075_body.png",
	"res://Art/100_body.png",
]
var health_textures = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# get player info
	player_health = 100
	MAX_PLAYER_HEALTH = player_health
	stamina = 30
	
	load_health_textures()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_health_image()
	upadate_player_attributes()
	pass

# changes the PlayerHealth nodes' image depenending on amount of health remaining
func update_health_image() -> void:
	var health_percentage = float(player_health) / float(MAX_PLAYER_HEALTH)
	print (health_percentage)
	
	if health_percentage >= 0.75:
		$MarginContainer/VBoxContainer/PlayerHealth.texture = health_textures.get("100")
	elif health_percentage < 0.75 && health_percentage > 0.50:
		$MarginContainer/VBoxContainer/PlayerHealth.texture = health_textures.get("75")
	elif health_percentage < 0.50 && health_percentage > 0.25:
		$MarginContainer/VBoxContainer/PlayerHealth.texture = health_textures.get("50")
	elif health_percentage < 0.25 && health_percentage != 0.00:
		$MarginContainer/VBoxContainer/PlayerHealth.texture = health_textures.get("25")
	elif health_percentage == 0.00:
		$MarginContainer/VBoxContainer/PlayerHealth.texture = health_textures.get("0")

# accepts a player node and takes the information from the node
func get_player_info() -> void:
	pass

# temp testing function to test health bar
func _on_button_pressed() -> void:
	if player_health > 0:
		player_health -= 10

# updates values of UI about user's interface
func upadate_player_attributes() -> void:
	# update health
	$MarginContainer/VBoxContainer/Attribute1/Value.text = str(player_health)

# loads texture data 
func load_health_textures() -> void:
	var curr_tex
	for i in tex_paths.size():
		curr_tex = ImageTexture.create_from_image(Image.load_from_file(tex_paths[i]))
		# add to dictionary		   key			value
		health_textures[str(i * 25)] = curr_tex
