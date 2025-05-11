extends Item

func OnBallBounce(_ball:Ball, _collider: Node)->void:
	if _collider is Ball:
		_ball.chainScoreCumulated += 50
		_collider.chainScoreCumulated += 50
