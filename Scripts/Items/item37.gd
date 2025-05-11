extends Item

var mult : float = 0.

func OnLevelStart(_level:Level)->void:
	#count 
	for item : Item in Globals.itemList.get_children():
		mult += 0.02
	Globals.scoreMult += mult


func OnLevelEnd() -> void:
	Globals.scoreMult -= mult
	mult = 0.


