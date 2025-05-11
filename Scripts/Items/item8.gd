extends Item

func OnLevelStart(level:Level)->void:
	Globals.chainPlayerBounces += 1

func OnLevelEnd() -> void:
	Globals.chainPlayerBounces -= 1

