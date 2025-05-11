extends Item

func OnBallBounce(_ball:Ball, _collider: Node)->void:
	var onlyOne : bool = 1
	for ball in Globals.level.balls.get_children():
		if ball is Ball:
			if onlyOne:
				onlyOne = 0
			else:
				return
	if _collider is BreakoutBlock:
		if _collider.health > 0:
			_collider.BallCollision()
			# increase score only if block has score
			if _collider.score > 0:
				_ball.level.score_manager.UpdateScore(_collider.score * Globals.scoreMult)
