extends Item

var size : bool = 0
var speed : bool = 0

func OnLevelEnd() -> void:
	if size:
		Globals.ChangeSize(-1)
		size = 0
	if speed:
		Globals.ChangeSpeed(-1)
		speed = 0

func OnOvertime() -> void:
	if Globals.sizeStage < 3:
		Globals.ChangeSize(1)
		size = 1
	if Globals.speedStage < 3:
		Globals.ChangeSpeed(1)
		speed = 1
	


