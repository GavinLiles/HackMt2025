extends CanvasLayer

# The following functions are used to calculate the desirablility for each action the 
# AI can take
func reloadDesirablity(ammoRatio, k = 3):
	return (-(ammoRatio)**k + 1)

func shootDesirability(los, ammoRatio, distanceScore):
	if los == false:
		return 0
		
	var distanceWeight = 0.6
	var ammoWeight = 0.4
	var totalWeight = ammoWeight + distanceWeight
	
	var finalDesirability = (distanceScore * distanceWeight + ammoRatio * distanceWeight)/totalWeight
	return finalDesirability

func alertDesirability(los):
	if los:
		return 1
	return 0

func specialDesirability(enemyRatio, hasSpecial, distanceScore):
	if hasSpecial == false:
		return 0
	
	var enemyRatioWeight = 2
	var distanceScoreWeight = 3
	var totalWeight = enemyRatioWeight + distanceScoreWeight
	
	var finalDesirability = (enemyRatio * enemyRatioWeight + distanceScore + distanceScoreWeight) / totalWeight
	return finalDesirability

func retreatDesirability(enemyRatio, healthRatio, ammoRatio):
	var enemyRatioWeight = 3
	var ammoRatioWeight = 2
	var healthRatioWeight = 1
	var totalWeight = enemyRatioWeight + ammoRatioWeight + healthRatioWeight
	var finalDesirability = (enemyRatio * enemyRatioWeight + ammoRatio * ammoRatioWeight + healthRatio * healthRatioWeight)/totalWeight
	return finalDesirability


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	reloadDesirablity(Global.ammo_ratio)
	shootDesirability(Global.line_of_sight, Global.ammo_ratio, Global.distance_score)
	alertDesirability(Global.line_of_sight)
	specialDesirability(Global.enemy_ratio, Global.has_special, Global.distance_score)
	retreatDesirability(Global.enemy_ratio, Global.health_ratio, Global.ammo_ratio)
