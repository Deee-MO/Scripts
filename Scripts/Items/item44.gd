extends Item

var addedMult : float = 0

func OnFirstBallShot(_ball:Ball)->void:
	addedMult = Globals.currency * 0.05 / 1000
	Globals.scoreMult += addedMult

func OnLevelEnd() -> void:
	Globals.scoreMult -= addedMult
