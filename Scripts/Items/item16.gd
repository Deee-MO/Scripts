extends Item

const blank : PackedScene = preload("res://Scenes/Items/_item.tscn")

func OnOvertime() -> void:
	#to prevent loss in overtime add fake ball to balls in level
	var dummy = blank.instantiate()
	Globals.player.level.balls.add_child(dummy)
	
func OnLevelEnd() -> void:
	#give 1 health if it exceeds current
	Globals.playerHealth = max(Globals.playerHealth, 1)

func CheckFiltration() -> bool:
	for item in Globals.itemList.get_children():
		if item.id == id:
			FullItemList.FilterList[id]  = FullItemList.Filter.None
			return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
