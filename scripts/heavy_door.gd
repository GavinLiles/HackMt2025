extends Node2D

@export var sp = 25
@export var range_min = 0
@export var range_max = 1

@onready var anim = $AnimationPlayer
var shattered = false
var opened = false
var breached = false
var locked

var lock_side = "cw"
var open_direction = "cw"
var bs
var bt

#TEMP
var signal_in

var str = 0

func _process(delta: float) -> void:
	if bt == -1:
		_close()
	elif bt == 0:
		_open()
	elif bt == 1:
		_basic_breach(bs)
	elif bt == 2:
		_tool_breach(bs)
	elif bt == 3:
		_charge_breach()

func _ready() -> void:
	var rand_int = randf_range(range_min, range_max)
	if rand_int == 1:
		locked = true
		sp += 10
	else:
		locked = false

func _close():
	pass

func _open():
	#check if door unlocked
	if !locked and !opened:
		$Open_Audio.play()
		anim.play("door_cw")
		opened = true
	#if not door no open
	else:
		pass

func _basic_breach(bs):
	#get strength stat from operator
	#subtract from sp breach score amount
	sp -= bs
	if sp >= 1:
		#add effect / shake
		return
	if !breached and sp < -15:
		#shatter the door
		shattered = true
		breached = true
		if shattered:
			$Break_Audio.play()
			$Hinge/CharacterBody2D/CollisionShape2D.disabled = true
			$Hinge/CharacterBody2D/Sprite2D.visible = false
		pass
	
	elif !breached and sp > -15 and sp < 0:
		#breached
		breached = true
		locked = false
		anim.play("door_cw_breach")
		

func _tool_breach(bs):
	#subtract breach score
	sp -= bs
	if sp < -15:
		#shatter the door
		shattered = true
		breached = true
		if shattered:
			$Break_Audio.play()
			$Hinge/CharacterBody2D/CollisionShape2D.disabled = true
			$Hinge/CharacterBody2D/Sprite2D.visible = false

	elif !breached and sp > -15 and sp < 0:
		#door is breached
		breached = true
		locked = false
		anim.play("door_cw_breach")
		$Break_Audio.play()
		pass
	else:
		#door shakes, no open
		pass
	pass

func _charge_breach():
	sp = -999
	#fuck the door up
	#no mo door
	shattered = true
	breached = true
	if shattered:
		$Break_Audio.play()
		$CharacterBody2D/Sprite2D.visible = false
		$CharacterBody2D/CollisionShape2D.disabled = true
	pass


func _signal():
	bs = signal_in
	bt = signal_in
