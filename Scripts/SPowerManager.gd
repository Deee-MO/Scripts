extends Node2D

const SPINPUT = "spower"

enum Power{
	TIMESLOWDOWN = 1,
	BALLREPEL = 2
}

@onready var cdDelay: Timer = $CDDelay

var curSPower : int = 2
#upgradable stats
var maxMeterValue : float 
var meterSpeed : float 
var meterPowerStage : int
#powerspecific stats
var slowDownModifier : float#TIMESLOWDOWN
var repelDistance : float #BALLREPEL
#meter value
var curMeterValue : float 
#usecost per action or per secoond/depends on power
var curSPowerCost : float
#to not instantly replenish meter after use
var OnCD : bool = 0
#for continuous powers
var inUse : bool = 0

var player : Player

func _ready() -> void:
	SetSPower()

func _physics_process(delta: float) -> void:
	
	UsePower(delta)
	MeterManager(delta)
	##change it
	if player.level != null:
		player.level.uiright.setCurMeter(curMeterValue)


func SetSPower()->void:
	#take from global info
	curSPower = Globals.playerSPower
	#assign cost
	match curSPower: 
		Power.TIMESLOWDOWN:
			curSPowerCost = 500
		Power.BALLREPEL:
			curSPowerCost = 500
	SetMeterMax()
	SetMeterSpeed()
	SetMeterPower()

func SetMeterMax()->void:
	maxMeterValue = Globals.meterMax
	curMeterValue = maxMeterValue
	
func SetMeterSpeed()->void:
	meterSpeed = Globals.meterSpeed

func SetMeterPower()->void:
	meterPowerStage = Globals.meterPowerStage
	match curSPower: 
		Power.TIMESLOWDOWN:	
			match meterPowerStage:
				0:
					slowDownModifier = 1.5
				1:
					slowDownModifier = 2.
				2:
					slowDownModifier = 3.
				3:
					slowDownModifier = 4.
		
		Power.BALLREPEL:
			match meterPowerStage:
				0:
					repelDistance = 250.
				1:
					repelDistance = 450.
				2:
					repelDistance = 650.
				3:
					repelDistance = 1500.
	

func UsePower(delta : float)-> void:
	if OnCD:
		return
	match curSPower: 
		Power.TIMESLOWDOWN:	
			TimeSlowDown(delta)
		
		Power.BALLREPEL:
			BallRepel()
	

#TIMESLOWDOWN power effect
func TimeSlowDown(delta : float)->void:
	#if cant use
	if curMeterValue < curSPowerCost/2 and !inUse:
		return
	#auto stop the power at 0 meter 
	if curMeterValue <= 0 and inUse:
		Globals.ChangeGameSpeedBy(slowDownModifier)
		OnCD = 1
		inUse = 0
		cdDelay.start()
		return
	#activate power, set inUse upon first pressing input button, also stop meter here to not recharge while inUSe
	if Input.is_action_just_pressed(SPINPUT):
		inUse = 1
		Globals.ChangeGameSpeedBy(1./slowDownModifier)
	#reduce meter by cost per second
	if Input.is_action_pressed(SPINPUT) and inUse:
		curMeterValue -= curSPowerCost * delta
	#stop power at input button release and launch delay timer
	if Input.is_action_just_released(SPINPUT) and inUse:
		Globals.ChangeGameSpeedBy(slowDownModifier)
		OnCD = 1
		inUse = 0
		cdDelay.start()

#BALLREPEL power effect
func BallRepel()-> void:
	#when pressed, activated once
	if Input.is_action_just_pressed(SPINPUT):
		#stop if not enough meter
		if curMeterValue < curSPowerCost:
			return
		#find the ball
		##change if ever add more or something other than balls
		var ball = get_tree().get_first_node_in_group("Ball")
		#reduce meter by cost
		curMeterValue -= curSPowerCost
		#distance check, dont affect outside of range
		if (ball.global_position - global_position).lenght() > repelDistance:
			return
		#effect / change balls velocity to direction away from player * max(balls speed, 300)
		if ball.velocity.length() >= 300:
			ball.velocity = (ball.global_position - global_position).normalized() * ball.velocity.length()
		else:
			ball.velocity = (ball.global_position - global_position).normalized() * 300
		#set meter delay
		OnCD = 1
		cdDelay.start()

#for recharging meter
func MeterManager(delta : float)-> void:
	#stop if delaytimer or already max
	if inUse or OnCD or curMeterValue >= maxMeterValue: 
		return
	#250 gives 2 seconds for full recharge of 500
	curMeterValue += delta * meterSpeed
	if curMeterValue > maxMeterValue:
		curMeterValue = maxMeterValue
		print("Power Meter  ---  ",curMeterValue)

#reset CDDelay
func _on_cd_delay_timeout() -> void:
	OnCD = 0

