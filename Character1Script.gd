extends CharacterBody2D

#Need to finish line removal
#Make an arrow for direction
#FOV

# Nodes
@onready var character1 = $"../CharacterBody2D3"
@onready var gun_muzzle1 = $"../CharacterBody2D/GunMuzzle3"

@export var bullet_scene: PackedScene # Bullet Scene
@export var bullet_speed = 700
@export var MAX_HEALTH = 100
@export var health = 100
@export var strength = 5
@export var stamina = 10
@export var weapon_range = 100
#@export var friendly = true

var keep_shooting = false # for continuous shooting at targets
var shoot_target = false # coords to shoot at


# Variables
var initial_mouse_position
var drawing_path = false
var path_points = []
var can_move = false
var current_target_index = 0
var speed = 50
var rotation_speed = 5
var fired = false
var can_draw = true
var locked_cord
var selected = 1  # 1 for character1, 2 for character2
var start_cords
var counter = 0

func _ready():
	$VisionCone2D2/VisionConeRenderer.color = Color(0, .5, .5, .5) # teal
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				initial_mouse_position = get_global_mouse_position()
				var new_selection = is_mouse_over_character()
				if new_selection == 1:
					selected = new_selection
					print("Selected Character:", health)
					if event.button_index == MOUSE_BUTTON_LEFT:
						fired = false
						start_drawing(get_global_mouse_position())
			else:
				stop_drawing()

		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if selected > 0:  # Only allow shooting if a character is selected
				shoot_at(get_global_mouse_position())
				fired = true

	elif event is InputEventMouseMotion and drawing_path:
		update_drawing(get_global_mouse_position())

func start_drawing(start_position: Vector2):
	start_cords = start_position
	if selected == 0:
		return  # Prevent drawing if no character is selected
	drawing_path = true
	can_draw = false
	path_points.clear()
	path_points.append(start_position)
	$"../arrow1".clear_points()


	$"../arrow1".add_point(start_position)
	

func update_drawing(new_position: Vector2):
	path_points.append(new_position)
	$"../arrow1".add_point(new_position)
	
func start_moving():
	var arrow = get_node("../arrow")  
	if arrow and arrow.has_method("change_player"): 
		arrow.change_player(selected) # Change color depending on the player


func stop_drawing():
	drawing_path = false
	can_draw = true
	can_move = true
	current_target_index = 0
	move_character_along_path()

func shoot_at(position):
	fired = true
	
	if bullet_scene == null:
		return  # Prevent shooting if no bullet scene is assigned

	# get position to shoot at
	locked_cord = position
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)  # Add the bullet to the scene
	
	bullet.global_position = $GunMuzzle.global_position  # Start from gun muzzle
	var shoot_direction = (locked_cord - $GunMuzzle.global_position).normalized()
	bullet.rotation = shoot_direction.angle()  

	# Ensure the bullet has velocity
	if bullet.has_method("set_velocity"):
		bullet.set_velocity(shoot_direction * bullet_speed)  # Adjust speed as needed

	if selected:
		shoot_direction = (locked_cord - global_position).normalized()
		rotation = shoot_direction.angle()

	
func is_mouse_over_character() -> int:
	if global_position.distance_to(initial_mouse_position) < 15:
		print("Selected Character 2")
		return 1
	else:
		selected = 0

	return 0
	
#func rotate_character():

func move_character_along_path():
	if not can_move:
		return

	if global_position.distance_to(initial_mouse_position) > 10 and current_target_index == 0:
		can_move = false
		return

	if path_points.size() < 2 or current_target_index >= path_points.size():
		can_move = false
		current_target_index = 0
		return

	var target_position = path_points[current_target_index]
	var direction = (target_position - global_position).normalized()

	if not fired:
		var target_angle = direction.angle()
		rotation = lerp_angle(rotation, target_angle, rotation_speed * get_process_delta_time())
	elif fired:
		var shoot_direction = (locked_cord - global_position).normalized()
		rotation = shoot_direction.angle()

	velocity = direction * speed
	move_and_slide()

	if global_position.distance_to(target_position) < 5:
		current_target_index += 1
		$"../arrow3".remove_point(0)
		
func _process(delta: float):
	move_character_along_path()
	#if keep_shooting && $BulletTimer.is_stopped():
		#$BulletTimer.start()
		
		

func _on_vision_cone_area_body_entered(body: Node2D) -> void:
	#$VisionCone2D2/VisionConeRenderer.color = Color(.8, .2, 0, .5) # redish
	#print(body.global_position)
	#shoot_target = body.global_position
	##if body.friendly == true:
	#shoot_at(shoot_target)
	#keep_shooting = true
	pass



func _on_vision_cone_area_body_exited(body: Node2D) -> void:
	#$VisionCone2D2/VisionConeRenderer.color = Color(0, .5, .5, .5) # teal
	#keep_shooting = false
	#$BulletTimer.stop()
	pass


func _on_bullet_timer_timeout() -> void:
	shoot_at(shoot_target)
	print("cont. interst")
