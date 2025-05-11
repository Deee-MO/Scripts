extends Item

func OnLevelStart(_level:Level)->void:
	Globals.overtimeTime += 5
	
	
func OnLevelEnd() -> void:
	Globals.overallTime -= 5


