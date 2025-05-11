extends Item

var totalMult : float = 0.

func OnLevelStart(_level:Level)->void:
	var copies : int = 0
	#count copies
	for item : Item in Globals.itemList.get_children():
		if item.id == id:
			copies += 1
	#calculate total mult per copy
	var mult : int = copies / 3
	if mult > 0:
		totalMult = float(mult) / float(copies)
		
	Globals.scoreMult += totalMult
	
func OnLevelEnd() -> void:
	Globals.scoreMult -= totalMult
	totalMult = 0.


