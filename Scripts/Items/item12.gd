extends Item

func OnFirstBallShot(ball:Ball)->void:
	ball.chainScoreStart += 100
	ball.chainScoreCumulated += 100


