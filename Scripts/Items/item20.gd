extends Item

func _ready() -> void:
	held = 0

func OnPickUp()->void:
	Globals.ChangeLife(Globals.playerMaxHealth - Globals.playerHealth)

func CheckFiltration() -> bool:
	if FullItemList.FilterList[id] != FullItemList.Filter.Drop:
		FullItemList.FilterList[id]  = FullItemList.Filter.Drop
		return 0
	
	if Globals.playerHealth >= Globals.playerMaxHealth:
		return 0
	return 1
