extends Item

func OnLevelStart(level:Level)->void:
	Globals.scoreMult += 1
	
func OnLevelEnd():
	Globals.scoreMult -= 1
	
func OnPickUp()->void:
	Globals.ChangeMaxLife(-1)
	Globals.ChangeSize(-1)
	Globals.ChangeSpeed(-1)

func CheckFiltration() -> bool:
	if !Globals.sizeStage > -2:
		FullItemList.FilterList[id]  = FullItemList.Filter.None
		return 0
	if !Globals.speedStage > -2:
		FullItemList.FilterList[id]  = FullItemList.Filter.None
		return 0
	if !Globals.playerMaxHealth > 1:
		FullItemList.FilterList[id]  = FullItemList.Filter.None
		return 0
	
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
	
