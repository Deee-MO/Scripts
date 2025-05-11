extends Item

func OnLevelStart(level:Level)->void:
	var newScore = level.score_manager.targetScore
	level.score_manager.SetTargetScore(newScore*0.95)

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
