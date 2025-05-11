extends Item

func OnOvertime() -> void:
	Globals.player.level.SpawnBall(Globals.player.ball_spawn_point.global_position, false)
	
