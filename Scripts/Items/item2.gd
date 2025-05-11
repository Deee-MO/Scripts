extends Item

func OnPickUp()->void:
	Globals.ChangeSpeed(1)

func OnRemoval()->void:
	Globals.ChangeSpeed(-1)

func CheckFiltration() -> bool:
	if !Globals.speedStage < 3:
		FullItemList.FilterList[id]  = FullItemList.Filter.None
		return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
