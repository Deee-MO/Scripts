extends Item

func _ready() -> void:
	held = 0

func OnPickUp()->void:
	Globals.currency += 1000
	if Globals.level != null:
		Globals.level.uiright.setMoneyText()

func CheckFiltration() -> bool:
	if !(FullItemList.FilterList[id] == FullItemList.Filter.Drop):
		FullItemList.FilterList[id] = FullItemList.Filter.Drop
		return 0
	return 1
