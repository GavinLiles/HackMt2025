#Function Tree
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

func alertDesirability(los, soundVolume):
	var soundThreshold = 0.5
	if los or soundVolume >= soundThreshold:
		return 1
	return 0

func specialDesirability(enemyRatio, hasSpecial, distanceScore):
	if hasSpecial == false:
		return 0
	throwGrenade = 0
	elif timer += 1:
		throwGrenade = timer * distanceScore
		return throwGrenade

func retreatDesirability (enemyRatio, healthRatio, ammoRatio):
	var enemyRatioWeight = 3
	var ammoRatioWeight = 2
	var healthRatioWeight = 1
	var totalWeight = enemyRatioWeight + ammoRatioWeight + healthRatioWeight
	var finalDesirability = (enemyRatio * enemyRatioWeight + ammoRatio * ammoRatioWeight + healthRatio * healthRatioWeight)/totalWeight
	return finalDesirability

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
