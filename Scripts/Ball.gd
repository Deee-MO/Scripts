extends CharacterBody2D

class_name Ball

@onready var collision_timer: Timer = $collisionTimer

var level : Level = null

var accel = 20
var dir :Vector2 = Vector2(-1,-1).normalized()
var speed = 400
var recoverable : bool = 1
#bonus chain score variables
var chainScoreStart : float = 0
var chainScoreAdditive : float
var chainScoreCumulated : float = 0
var chainPlayerBouncesMax: float
var chainPlayerBouncesCur: float = 0

func _ready() -> void:
	speed = Globals.ballStartSpeed
	accel = Globals.ballAcceleration
	chainPlayerBouncesMax = Globals.chainPlayerBounces
	chainScoreAdditive = Globals.chainScoreAdditive
	chainScoreCumulated = chainScoreStart

func _physics_process(delta: float) -> void:
	if velocity.x == 0:
		velocity.x = [-1, 1].pick_random()
	# bounce on collisions, gamespeed for time manipulation
	var collision : KinematicCollision2D = move_and_collide(velocity*delta*Globals.GameSpeed)
	if collision:
		var collider = collision.get_collider()
		
		if collider is Ball:
			AudioManager.PlaySound(AudioManager.SOUND.HITWALL)
			#not just bounce/ swap velocities for simple and "working" logic
			#also removes all added speed from aceleration from both balls
			#var speed1 = (velocity.length() - Globals.ballStartSpeed)/2.
			#var speed2 = (collider.velocity.length() - Globals.ballStartSpeed)/2.
			var temp = velocity.normalized()
			velocity = collider.velocity.normalized() * speed
			collider.velocity = temp * collider.speed
			#to avoid balls phasing into each other, slightly different from this functions in other classes
			BallCollision()
			collider.BallCollision()
		
		elif collider is Enemy:
			AudioManager.PlaySound(AudioManager.SOUND.HITBLOCK)
			#just bounce and trigger collision afk
			velocity = velocity.bounce(collision.get_normal())
			collider.BallCollision()
			
		elif collider is Player:
			AudioManager.PlaySound(AudioManager.SOUND.HITBLOCK)
			#if it somehow collides from underneath make it fall down, 12 pixels = appropriate leeway
			if global_position.y - 12 > collider.global_position.y:
				velocity = Vector2(0,500)
			else:
				#not just bounce, preserve speed and give new direction(from a point below player towards balls current position)
				var curSpeed = velocity.length()
				var newDir = Vector2(global_position - Vector2(collider.global_position.x,collider.global_position.y+50)).normalized()
				velocity = newDir * curSpeed
			#add a player bounce to counter
			chainPlayerBouncesCur += 1
			if chainPlayerBouncesCur > chainPlayerBouncesMax:
				# reset bonus chain score and current player bounces
				chainScoreCumulated = chainScoreStart
				chainPlayerBouncesCur = 0
			#trigger collision afk
			collider.BallCollision()
		
		elif collider is BreakoutBlock:
			AudioManager.PlaySound(AudioManager.SOUND.HITBLOCK)
			#just bounce
			velocity = velocity.bounce(collision.get_normal())
			var colScore = collider.score
			#trigger collision effects
			#if block will break, wait for it to break
			if collider.health <= 1:
				collider.BallCollision()
				await collider.tree_exited
			else:
				collider.BallCollision()
			# increase score only if block has score
			if colScore > 0:
				level.score_manager.UpdateScore((chainScoreCumulated + colScore) * Globals.scoreMult)
			# increase chainscore bonus
			chainScoreCumulated += chainScoreAdditive
			
		else:
			AudioManager.PlaySound(AudioManager.SOUND.HITWALL)
			#probably wall so just bounce
			velocity = velocity.bounce(collision.get_normal())
			#slightly increse vertical speed to avoid it being stuck bouncing left and right
			if velocity.y > 0:
				velocity.y += 5
			if velocity.y < 0:
				velocity.y -= 5
			if velocity.y == 0:
				velocity.y -= 5
		#trigger on bounce effects on the level
		level.BallBounce(self, collider)
	# normalize(from bounces) and accelerate 
	velocity += velocity.normalized() * accel * delta

func SetRecoverable(rec : bool) ->void:
	recoverable = rec
	var color = 0.5 + (0.5 * float(rec))
	modulate = Color(color,color,color)

func BallCollision()->void:
	#change mask to not see other balls
	collision_timer.start()
	#2 is the ball layer
	set_collision_mask_value(2, 0)

func _on_collision_timer_timeout() -> void:
	set_collision_mask_value(2, 1)


