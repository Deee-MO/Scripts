extends Item

func OnBallShot(ball:Ball)->void:
	ball.chainScoreStart += 20
	ball.chainScoreCumulated += 20


