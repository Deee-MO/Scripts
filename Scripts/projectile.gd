extends CharacterBody2D

var dir :Vector2 = Vector2(-1,-1).normalized()
var speed = 300
var distanceLimit : float = 1000
var distanceCur : float = 0
var stunTime : float = 2


func _physics_process(delta: float) -> void:
	#if distance exceeds max limit(out of bounds) destroy itself
	if distanceCur > distanceLimit:
		queue_free()
	#update speed
	velocity = dir * speed
	#take new distance traveled in a frame as 2d vector, add its length to distance traveled
	var newDistance = velocity*delta*Globals.GameSpeed
	distanceCur += newDistance.length()
	#move and collide that new vector, collider mask should be set to only collide with player
	var collision : KinematicCollision2D = move_and_collide(newDistance)
	if collision:
		var collider = collision.get_collider()
		#should be the only case
		if collider is Player:
			AudioManager.PlaySound(AudioManager.SOUND.BALLLOST)
			#stun player for stunTime seconds
			collider.IsStunned(stunTime)
			#destroy itself
			queue_free()
		


