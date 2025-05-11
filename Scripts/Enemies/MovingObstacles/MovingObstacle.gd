extends Enemy

@onready var follower: PathFollow2D = $".."

func inphysicsprocess(delta:float)->void:
	if stop:
		return
	
	#turn around at endpoints
	if follower.progress_ratio >= 1:
		dir = -1
	if follower.progress_ratio <= 0:
		dir = 1
	
	#advance path progress, gamespeed for time manipulation
	follower.progress += dir * speed * delta * Globals.GameSpeed
	
