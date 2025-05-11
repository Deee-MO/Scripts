extends BreakoutBlock

var dir : Vector2 = Vector2(0,1)
var speed : float = 40
var distanceLimit : float = 1000
var distanceCur : float = 0

func _process(delta: float) -> void:
	#dont move if at distance limit
	if distanceCur >= distanceLimit:
		queue_free()
	
	#frame distance passed
	var dist = dir * delta * speed * Globals.GameSpeed
	position += dist
