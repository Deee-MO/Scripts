extends Item

func OnPickUp()->void:
	Globals.ChangeMeterSpeed(1)

func OnRemoval()->void:
	Globals.ChangeMeterSpeed(-1)

func CheckFiltration() -> bool:
	if !Globals.meterSpeedStage < 3:
		FullItemList.FilterList[id] = FullItemList.Filter.None
		return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
