extends Item

func OnLevelEnd() -> void:
	Globals.scoreMult -= 0.1
	
func OnLevelStart(_level:Level)->void:
	Globals.scoreMult += 0.1


