extends CharacterBody2D

class_name Enemy

@onready var collision_timer: Timer = $CollisionTimer

@export var speed : int = 300
@export var accel : int = 5

var dir : int = 0
var stop : bool = 0

func inready()->void:
	pass

func _ready() -> void:
	collision_timer.wait_time = Globals.collisionAFKTimer
	inready()

func inphysicsprocess(delta:float)->void:
	pass

func _physics_process(delta: float) -> void:
	if stop:
		return

	#subprocess for extending classes/ need to get dir from here
	inphysicsprocess(delta)

# stop actions after collision / bounces were unpredicable without it
func BallCollision()->void:
	collision_timer.start()
	stop = 1
	
# remove collision afk status
func _on_collision_timer_timeout() -> void:
	stop = 0
