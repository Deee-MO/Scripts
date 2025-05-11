extends Item

func OnPickUp()->void:
	Globals.ChangeMeterPower(1)

func OnRemoval()->void:
	Globals.ChangeMeterPower(-1)

func CheckFiltration() -> bool:
	if !Globals.meterPowerStage < 3:
		FullItemList.FilterList[id] = FullItemList.Filter.None
		return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
