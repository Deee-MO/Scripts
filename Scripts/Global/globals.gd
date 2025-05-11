extends Node

#meta stats
var difficulty : int = 0
var stage : int = 0
var currency : int = 0
var overallScore : float = 0.
var overallTime : float = 0.
var level:Level
#items
@onready var itemList: Node = $ItemList
#score stats
var scoreMult = 1
#meta STATs:
var collisionAFKTimer = 0.05
var playerSPower : int = 1
var GameSpeed : float = 1.
#STATs/Current Upgrades list
var player:Player
var playerHealth : int = 3
#basic Stats
var playerMaxHealth:int = 3
var sizeStage:int = 0
var speedStage:int = 0
#meter stats
var meterMaxStage:int = 0
var meterSpeedStage:int = 0
var meterPowerStage:int = 0
#actual values from stages for basic stats
var playerSpeed:float = 600
var playerSize:float = 1
#actual values from stages for meter stats
var meterMax:float = 1000
var meterSpeed:float = 250
#ball stats
var ballStartSpeed : float = 400
var ballAcceleration:float = 20
var chainScoreAdditive:float = 20
var chainPlayerBounces:float = 0
#overtime stats
var overtimeTime:float = 5

#reset all global stats to originals
func Reset()->void:
	difficulty = 0
	stage = 0
	currency = 0
	overallScore = 0.
	overallTime = 0.
	level = null
	for item in itemList.get_children():
		item.queue_free()
	scoreMult = 1
	collisionAFKTimer = 0.05
	playerSPower = 1
	GameSpeed = 1.
	player = null
	playerHealth = 3
	playerMaxHealth = 3
	sizeStage = 0
	speedStage = 0
	meterMaxStage = 0
	meterSpeedStage = 0
	meterPowerStage = 0
	playerSpeed = 600
	playerSize = 1
	meterMax = 1000
	meterSpeed = 500
	ballStartSpeed = 400
	ballAcceleration = 20
	chainScoreAdditive = 20
	chainPlayerBounces = 0
	overtimeTime = 5
	#reset filtraition list
	for id in FullItemList.List.keys():
		FullItemList.FilterList[id] = FullItemList.Filter.All

func ResetFiltration()->void:
	for id in FullItemList.List.keys():
		var item: Item = load(FullItemList.List[id][0]).instantiate()
		item.CheckFiltration()
		item.queue_free()

func ChangeLife(added:int)->void:
	#min to not overheal
	playerHealth = min(playerHealth + added,playerMaxHealth)
	if player.level != null:
		player.level.uiright.setBallsHeld(playerHealth)

func ChangeMaxLife(added : int)->void:
	playerMaxHealth += added
	playerMaxHealth = max(playerMaxHealth, 1)
	#if max health increase, also heal it and check for overhealing just in case
	playerHealth = min(max(playerHealth + added, playerHealth),playerMaxHealth)

func ChangeSize(stage:int)->void:
	#changes stage BY given amount, assign size with respect to new stage
	sizeStage += stage
	sizeStage = min(sizeStage, 3)
	sizeStage = max(sizeStage, -2)
	match sizeStage:
		0:
			playerSize = 1
			player.SetSize(playerSize)
		1:
			playerSize = 1.5
			player.SetSize(playerSize)
		2:
			playerSize = 2
			player.SetSize(playerSize)
		3:
			playerSize = 2.5
			player.SetSize(playerSize)
		-1:
			playerSize = 0.75
			player.SetSize(playerSize)
		-2:
			playerSize = 0.5
			player.SetSize(playerSize)

func ChangeSpeed(stage:int)->void:
	#changes stage BY given amount, assign speed with respect to new stage
	speedStage += stage
	speedStage = min(speedStage, 3)
	speedStage = max(speedStage, -2)
	match speedStage:
		0:
			playerSpeed = 600
			player.speed = playerSpeed
		1:
			playerSpeed = 800
			player.speed = playerSpeed
		2:
			playerSpeed = 1000
			player.speed = playerSpeed
		3:
			playerSpeed = 1200
			player.speed = playerSpeed
		-1:
			playerSpeed = 500
			player.speed = playerSpeed
		-2:
			playerSpeed = 250
			player.speed = playerSpeed

func ChangeMeterMax(stage:int)->void:
	#changes stage BY given amount, assign speed with respect to new stage
	meterMaxStage += stage
	meterMaxStage = min(meterMaxStage, 3)
	meterMaxStage = max(meterMaxStage, -2)
	match meterMaxStage:
		0:
			meterMax = 1000
			player.SetMeterMax()
		1:
			meterMax = 1500
			player.SetMeterMax()
		2:
			meterMax = 2000
			player.SetMeterMax()
		3:
			meterMax = 2500
			player.SetMeterMax()
		-1:
			meterMax = 500
			player.SetMeterMax()
		-2:
			meterMax = 0
			player.SetMeterMax()

func ChangeMeterSpeed(stage:int)->void:
	#changes stage BY given amount, assign speed with respect to new stage
	meterSpeedStage += stage
	meterSpeedStage = min(meterSpeedStage, 3)
	meterSpeedStage = max(meterSpeedStage, -2)
	match meterSpeedStage:
		0:
			meterSpeed = 250
			player.SetMeterSpeed()
		1:
			meterSpeed = 375
			player.SetMeterSpeed()
		2:
			meterSpeed = 500
			player.SetMeterSpeed()
		3:
			meterSpeed = 625
			player.SetMeterSpeed()
		-1:
			meterSpeed = 125
			player.SetMeterSpeed()
		-2:
			meterSpeed = 50
			player.SetMeterSpeed()

func ChangeMeterPower(stage:int)->void:
	#changes stage BY given amount, assign speed with respect to new stage
	meterPowerStage += stage
	meterPowerStage = min(meterPowerStage, 3)
	meterPowerStage = max(meterPowerStage, 0)
	player.SetMeterPower()

func ChangeGameSpeedBy(mult : float)->void:
	AudioManager.Music[AudioManager.curTrack].pitch_scale *= mult
	GameSpeed *= mult

