extends Item

func OnFirstBallShot(ball:Ball)->void:
	var timer = 0.1
	for item in Globals.itemList.get_children():
		if item.id == id:
			if item == self:
				break
			else:
				timer += 0.1
	await get_tree().create_timer(timer).timeout 
	ball.level.SpawnBall(Globals.player.ball_spawn_point.global_position, false)
	


