extends Item

func OnBallLost(_ball:Ball) -> void:
	if !(Globals.playerHealth > 0 or Globals.player.level.balls.get_child_count() != 0):
		Globals.ChangeLife(Globals.playerMaxHealth)
	FullItemList.RemoveItem(self)

func CheckFiltration() -> bool:
	for item in Globals.itemList.get_children():
		if item.id == id:
			FullItemList.FilterList[id]  = FullItemList.Filter.None
			return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
