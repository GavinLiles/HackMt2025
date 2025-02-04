extends CharacterBody2D

#Need to finish line removal
#Make an arrow for direction
#FOV


# Nodes
@onready var line = $"../arrow1"
@onready var character1 = $"../CharacterBody2D"
@onready var character2 = $"../CharacterBody2D2"
@onready var character3 = $"../CharacterBody2D3"
@onready var character4 = $"../CharacterBody2D4"
@onready var gun_muzzle1 = $"../CharacterBody2D/GunMuzzle"
@onready var gun_muzzle2 = $"../CharacterBody2D2/GunMuzzle2"
@onready var gun_muzzle3 = $"../CharacterBody2D3/GunMuzzle3"
@onready var gun_muzzle4 = $"../CharacterBody2D4/GunMuzzle4"

@export var bullet_scene: PackedScene # Bullet Scene

func _ready():
	line.width = .25

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
var selected = 0  # 1 for character1, 2 for character2
var start_cords
var counter = 0
var pause = false

func _input(event):
	selected = 0
	if event.is_action_pressed("ui_select"):
		if pause == true:
			print("Spacebar is active")
			pause = false
		elif pause == false:
			print("Spacebar is unactive")
			pause = true
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				initial_mouse_position = get_global_mouse_position()
				var new_selection = is_mouse_over_character()
				if new_selection > 0:
					selected = new_selection

					print("Selected Character:", selected)
					if event.button_index == MOUSE_BUTTON_LEFT:
						fired = false
						start_drawing(get_global_mouse_position())
			else:
				stop_drawing()

		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if selected > 0:  # Only allow shooting if a character is selected
				shoot()
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
	line.clear_points()


	line.add_point(start_position)
	

func update_drawing(new_position: Vector2):
	path_points.append(new_position)
	line.add_point(new_position)
	
#


func stop_drawing():
	drawing_path = false
	can_draw = true
	can_move = true
	current_target_index = 0
	move_character_along_path()

func shoot():
	fired = true
	
	#var character = character1 if selected == 1 else character2
	var character
	
	if selected == 1:
		character = character1
	elif selected == 2:
		character = character2
	elif selected == 3:
		character = character3
	elif selected == 4:
		character = character4
	
	
	
	
	
	if selected == 0 or bullet_scene == null:
		return  # Prevent shooting if no character is selected or no bullet scene

	locked_cord = get_global_mouse_position() # The coordinates of where the cursor last was when shooting
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)  # Adds the bullet to the scene

	var muzzle = null
	
	if selected == 1: # If character 1
		muzzle = gun_muzzle1
	elif selected == 2: # If character 2
		muzzle = gun_muzzle2
	elif selected == 3: # If character 2
		muzzle = gun_muzzle3
	elif selected == 4: # If character 2
		muzzle = gun_muzzle4

	bullet.global_position = muzzle.global_position
	bullet.direction = (locked_cord - muzzle.global_position).normalized()
	bullet.rotation = bullet.direction.angle()
	
	if can_draw:
		var shoot_direction = (locked_cord - character.global_position).normalized()
		character.rotation = shoot_direction.angle()		
	
	
func is_mouse_over_character() -> int:
	if character1.global_position.distance_to(initial_mouse_position) < 15:
		print("Selected Character 1")
		return 1
	elif character2.global_position.distance_to(initial_mouse_position) < 15:
		print("Selected Character 2")
		return 2
	elif character3.global_position.distance_to(initial_mouse_position) < 15:
		print("Selected Character 3")
		return 3
	elif character4.global_position.distance_to(initial_mouse_position) < 15:
		print("Selected Character 4")
		return 4

	return 0
	
#func rotate_character():
	

func move_character_along_path():
	if not can_move or selected == 0: 
		return

	var character
	
	if selected == 1:
		character = character1
	elif selected == 2:
		character = character2
	elif selected == 3:
		character = character3
	elif selected == 4:
		character = character4	
	

	if character.global_position.distance_to(initial_mouse_position) > 10 and current_target_index == 0:
		can_move = false
		print("Too far.")
		return
	
	if path_points.size() < 2 or current_target_index >= path_points.size():
		can_move = false
		current_target_index = 0
		return

	var target_position = path_points[current_target_index]
	var direction = (target_position - character.global_position).normalized()

	if not fired: # If there have be no shots fired it will just follow the line normally
		var target_angle = direction.angle()
		character.rotation = lerp_angle(character.rotation, target_angle, rotation_speed * get_process_delta_time())
	elif fired and locked_cord: # If there have been shots fired then it will lock its vision at the direction where the cursor last clicked
		var shoot_direction = (locked_cord - character.global_position).normalized()
		character.rotation = shoot_direction.angle()
	
	if not pause:
		velocity = direction * speed
		character.velocity = velocity
		character.move_and_slide()
	else:
		pass
	#character.global_position = character.global_position.move_toward(target_position, speed * get_process_delta_time())

	if character.global_position.distance_to(target_position) < 5 and not pause:
		current_target_index += 1
		line.remove_point(0)

func _process(delta: float):
	move_character_along_path()
