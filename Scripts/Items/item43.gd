extends Item

var size : bool = 0
var speed : bool = 0
var power : bool = 0

func OnLevelEnd() -> void:
	if size:
		Globals.ChangeMeterMax(-1)
		size = 0
	if speed:
		Globals.ChangeMeterSpeed(-1)
		speed = 0
	if power:
		Globals.ChangeMeterPower(-1)
		speed = 0

func OnOvertime() -> void:
	if Globals.meterMaxStage < 3:
		Globals.ChangeMeterMax(1)
		size = 1
	if Globals.meterSpeedStage < 3:
		Globals.ChangeMeterSpeed(1)
		speed = 1
	if Globals.meterPowerStage < 3:
		Globals.ChangeMeterPower(1)
		power = 1
	Globals.level.uiright.setMaxMeter()
