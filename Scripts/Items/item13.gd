extends Item

func OnLevelStart(level:Level)->void:
	Globals.scoreMult += 1
	
func OnLevelEnd():
	Globals.scoreMult -= 1

func OnPickUp()->void:
	Globals.ChangeMeterMax(-1)
	Globals.ChangeMeterSpeed(-1)
	Globals.ChangeMeterPower(-1)

func CheckFiltration() -> bool:
	if !Globals.meterMaxStage > -2:
		FullItemList.FilterList[id]  = FullItemList.Filter.None
		return 0
	if !Globals.meterSpeedStage > -2:
		FullItemList.FilterList[id]  = FullItemList.Filter.None
		return 0
	if !Globals.meterPowerStage > 0:
		FullItemList.FilterList[id]  = FullItemList.Filter.None
		return 0
	
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
