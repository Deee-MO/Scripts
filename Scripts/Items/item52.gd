extends Item

var restrictingItems = [49, 52]

func OnBallShot(_ball:Ball) -> void:
	if !_ball.recoverable:
		_ball.SetRecoverable(1)
		var recordPos = _ball.global_position
		await get_tree().create_timer(0.15).timeout 
		_ball.level.SpawnBall(recordPos)
	

func CheckFiltration() -> bool:
	for item in Globals.itemList.get_children():
		if item.id in restrictingItems:
			FullItemList.FilterList[id]  = FullItemList.Filter.None
			return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
