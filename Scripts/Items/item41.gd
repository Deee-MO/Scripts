extends Item

func OnBallBounce(_ball:Ball, _collider: Node)->void:
	if _collider is BreakoutBlock and Globals.player.s_power_manager.inUse:
		Globals.level.score_manager.UpdateScore(_collider.score * 0.1)



