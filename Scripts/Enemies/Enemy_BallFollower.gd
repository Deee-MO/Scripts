extends Enemy

var ball : Ball = null
var ballTimeToCollide : float
var targetLockTimer : float = 0

func inphysicsprocess(delta:float)->void:
	#find a new ball to follow
	if targetLockTimer <= 0:
		targetLockTimer = 0.1
		#get all objects in ball list
		var balls = Globals.level.balls.get_children()
		
		#free current ball
		ball = null
		
		for object in balls:
			#only look at balls, lower than self, moving at self
			if (object is Ball and
			object.global_position.y > global_position.y and 
			object.velocity.y < 0):
				#ballTimeToCollide takes difference in y position, divides by y velocity, both negative numbers
				if !ball:
					ball = object
					ballTimeToCollide = (global_position.y - ball.global_position.y)/ball.velocity.y
				#if time till collision is smaller for object make it followed
				else:
					var objectTimeTiCollide = (global_position.y - object.global_position.y)/object.velocity.y
					if objectTimeTiCollide < ballTimeToCollide:
						ball = object
						ballTimeToCollide = objectTimeTiCollide
		
	targetLockTimer -= delta
	
	#afk conditions
	if !ball:
		dir = 0
		return
	
	# set follow the ball direction / 20 threshhold to stop jitter movement
	if ball.global_position.x - global_position.x > 20:
		dir = 1
	elif ball.global_position.x - global_position.x < -20:
		dir = -1
	else:
		dir = 0
	
	# in case of change in direction, reset momentum
	if velocity.x * dir <0:
		velocity = Vector2.ZERO
		
	#acclerate instead of setting max speed to stop jitter movement, clamp with delta for even acceleration
	velocity = lerp(velocity, Vector2(dir*speed,0), clamp(delta * accel, 0, 1))
	#gamespeed for time manipulation
	move_and_collide(velocity * delta*Globals.GameSpeed)

func BallCollision()->void:
	collision_timer.start()
	targetLockTimer = 0
	stop = 1
