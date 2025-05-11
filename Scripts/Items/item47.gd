extends Item

func OnOvertime() -> void:
	Globals.chainPlayerBounces += 999
	for ball in Globals.player.level.balls.get_children():
		if ball is Ball:
			ball.chainPlayerBouncesMax += 999
	
func OnLevelEnd() -> void:
	Globals.chainPlayerBounces -= 999
