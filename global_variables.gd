extends Node

# Global Variables and inputs for the UBAI. Please create another section for variables
# unrelated to the AI system.

#enums used for indexing the room_timer array
enum {
	GARAGE = 0,
	MASTER_BEDROOM,
	KITCHEN,
	LIVING_ROOM,
	BEDROOM,
	HALLWAY
}

#Blackboard Functions (static values)
func calcDistanceScore (distanceFromTarget, desiredFiringRange):
	var distanceDelta = distanceFromTarget - desiredFiringRange
	var distanceScore = 1-(2 * abs(distanceDelta)**2)/(1 + (abs(distanceDelta)))
	return distanceScore

func calcHealthRatio (currentHealth, maxHealth):
	var healthRatio = currentHealth/maxHealth
	return healthRatio

func calcAmmoRatio (currentAmmo, maxAmmo):
	var ammoRatio = currentAmmo/maxAmmo
	return ammoRatio
	

var line_of_sight = false
var dist_from_target = 5

var distance_score: float = 1
var health_ratio: float = 1
var ammo_ratio: float = 1
var enemy_ratio: float = 1 # IMPLEMENT THE FUNCTION FOR THIS
var sound_volume: float = 1 #INMPLEMENT THE FUNCTION FOR THIS

var curr_health = 100
var max_health = 100
var curr_ammo = 100
var max_ammo = 100
var has_special = false
var desired_firing_range = 5

var terrorist_count = 14
var operator_count = 4

var room_timers = [0,0,0,0,0,0]

func _process(delta):
	#UBAI functions
	distance_score = calcDistanceScore(dist_from_target, desired_firing_range)
	health_ratio = calcHealthRatio(curr_health, max_health)
	ammo_ratio = calcAmmoRatio(curr_ammo, max_ammo)
