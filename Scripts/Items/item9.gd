extends Item


func OnLevelStart(level:Level)->void:
	Globals.chainScoreAdditive += 20

func OnLevelEnd() -> void:
	Globals.chainScoreAdditive -= 20

