extends Item

func CheckFiltration() -> bool:
	if FullItemList.FilterList[id] != FullItemList.Filter.None:
		FullItemList.FilterList[id] = FullItemList.Filter.None
		return 0
	return 1
