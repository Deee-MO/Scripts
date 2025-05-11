extends Item

var started : bool = 0
var cumulatedBonusMult : float = 0

func _process(delta: float) -> void:
	if !started:
		return
	if Globals.player.dir == 0:
		cumulatedBonusMult += 0.02 * delta
	else:
		cumulatedBonusMult = 0

func OnFirstBallShot(_ball:Ball)->void:
	started = 1

func OnBallBounce(_ball:Ball, _collider: Node)->void:
	if _collider is BreakoutBlock:
		Globals.level.score_manager.UpdateScore(_collider.score * cumulatedBonusMult)
