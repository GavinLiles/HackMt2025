extends Area2D

var friendly_count = 0
var enemy_count = 0

Global.MASTER_BEDROOM
Global.room_timers[MASTER_BEDROOM]
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
	if friendly_count > 0 and enemy_count > 0 and !timing:
		$Timer.start()
		timing = true

func _on_timer_timeout() -> void:
	Global.room_timers[MASTER_BEDROOM] += 1
	if friendly_count > 0 and enemy_count > 0:
		$Timer.start()
	else:
		timing = false
		Global.room_timers[MASTER_BEDROOM] = 0
