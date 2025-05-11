extends Item

var timesAdded:int = 0

func OnBallBounce(_ball:Ball, collider: Node)->void:
	if collider is BreakoutBlock:
		Globals.scoreMult += 0.005
		timesAdded += 1

func OnLevelEnd() -> void:
	Globals.scoreMult -= 0.005 * float(timesAdded)
	timesAdded = 0


