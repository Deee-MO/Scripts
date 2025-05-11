extends Item

func OnLevelStart(_level:Level)->void:
	var added : float = Globals.currency * 0.1
	Globals.currency += added
