extends Item

func OnBallBounce(_ball:Ball, _collider: Node)->void:
	if _collider is BreakoutBlock:
		if randi() % 20 == 0:
			var recordPos = _ball.global_position
			await get_tree().create_timer(0.1).timeout
			if _ball:
				_ball.level.SpawnBall(recordPos, false)
