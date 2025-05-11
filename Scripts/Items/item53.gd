extends Item

func OnFirstBallShot(_ball:Ball)->void:
	_ball.speed *= 0.8
	_ball.velocity = _ball.velocity.normalized() * _ball.speed

func CheckFiltration() -> bool:
	var count : int = 0
	for item in Globals.itemList.get_children():
		if item.id == id:
			count = count + 1
	if count >= 5:
		FullItemList.FilterList[id]  = FullItemList.Filter.None
		return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1

