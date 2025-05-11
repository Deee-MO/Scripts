extends Item

func OnOvertime():
	Globals.scoreMult += 1
	
func OnLevelEnd():
	Globals.scoreMult -= 1


