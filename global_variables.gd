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
	

var line_of_sight
var dist_from_target

var distance_score
var health_ratio
var ammo_ratio

var curr_health
var max_health
var curr_ammo
var max_ammo
var has_special
var desired_firing_range

var terrorist_count
var operator_count

var room_timers = [0,0,0,0,0,0]

func _process(delta):
	#UBAI functions
	distance_score = calcDistanceScore(dist_from_target, desired_firing_range)
	health_ratio = calcHealthRatio(curr_health, max_health)
	ammo_ratio = calcAmmoRatio(curr_ammo, max_ammo)
