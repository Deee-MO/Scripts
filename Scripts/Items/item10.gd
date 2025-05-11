extends Item

func OnBallBounce(ball:Ball, collider: Node)->void:
	if collider is Ball or collider is Enemy or collider is Player or collider is BreakoutBlock:
		return
	#only wall is left ##currently
	else:
		ball.chainScoreCumulated += ball.chainScoreAdditive

func CheckFiltration() -> bool:
	for item in Globals.itemList.get_children():
		if item.id == id:
			FullItemList.FilterList[id]  = FullItemList.Filter.None
			return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
