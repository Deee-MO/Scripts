extends Item
func _ready() -> void:
	held = 0

func OnPickUp()->void:
	var ids = FullItemList.GetRandXUniqueItemsOfRarity(2, FullItemList.Rarity.COMMON, FullItemList.Filter.Drop)
	FullItemList.ApplyItem(ids[0])
	FullItemList.ApplyItem(ids[1])
	


