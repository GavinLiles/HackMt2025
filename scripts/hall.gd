extends Area2D

var friendly_count = 0
var enemy_count = 0
#Global.HALLWAY
#Global.room_timers[HALLWAY]
var timing = false

func _physics_process(delta):
# Get all bodies currently overlapping the detection area
	var overlapping_bodies = get_overlapping_bodies()
# Count friendlies and enemies
	friendly_count = 0
	enemy_count = 0

	for body in overlapping_bodies:
		if body.is_in_group("friendly"):
			friendly_count += 1
		elif body.is_in_group("enemy"):
			enemy_count += 1

# Display counts in the output console
	#print("Friendlies in area:", friendly_count)
	#print("Enemies in area:", enemy_count)

func _process(delta: float) -> void:
	Global.rooms[HALLWAY].op_count = friendly_count
	Global.rooms[HALLWAY].t_count = enemy_count
	if friendly_count > 0 and enemy_count > 0 and !timing:
		$Timer.start()
		timing = true

func _on_timer_timeout() -> void:
<<<<<<< HEAD
	#Global.room_timers[HALLWAY] += 1
=======
	Global.rooms[HALLWAY].timer += 1
>>>>>>> 34104d352f8b741cf886f260e8183ce4e0214591
	if friendly_count > 0 and enemy_count > 0:
		$Timer.start()
	else:
		timing = false
<<<<<<< HEAD
		#Global.room_timers[HALLWAY] = 0
=======
		Global.rooms[HALLWAY].timer = 0
>>>>>>> 34104d352f8b741cf886f260e8183ce4e0214591
