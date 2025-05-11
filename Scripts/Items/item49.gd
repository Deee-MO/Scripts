extends Item

var restrictingItems = [49, 52]

func OnPickUp()->void:
	Globals.ChangeMaxLife(-1 * Globals.playerMaxHealth)
	Globals.scoreMult += 1
	Globals.ballAcceleration *= 0.5

func OnRemoval()->void:
	Globals.scoreMult -= 1
	Globals.ballAcceleration *= 2


func CheckFiltration() -> bool:
	for item in Globals.itemList.get_children():
		if item.id in restrictingItems:
			FullItemList.FilterList[id]  = FullItemList.Filter.None
			return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
