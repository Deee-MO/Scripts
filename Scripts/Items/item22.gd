extends Item

func OnBallShot(_ball:Ball) -> void:
	Globals.scoreMult += 0.1
	
func OnBallLost(_ball:Ball) -> void:
	Globals.scoreMult -= 0.1

func OnLevelEnd() -> void:
	for ball in Globals.player.level.balls.get_children():
		if ball is Ball:
			Globals.scoreMult -= 0.1


