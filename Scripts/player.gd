extends CharacterBody2D

class_name Player

@onready var collision_timer: Timer = $collisionTimer
@onready var sprites: Node2D = $Sprites
@onready var collision_shape_2d: CollisionPolygon2D = $CollisionShape2D
@onready var s_power_manager: Node2D = $SPowerManager
@onready var ball_spawn_point: Node2D = $BallSpawnPoint

@export var speed : int

var right : bool = 0
var left : bool = 0
var dir : int = 0
var stop : bool = 0

var stunTimer : float = 0

var level: Level = null

func _ready() -> void:
	Effects.player = self
	Globals.player = self
	SetSize(Globals.playerSize)
	speed = Globals.playerSpeed
	s_power_manager.player = self
	
func _physics_process(delta: float) -> void:
	#for stun mechanic, if collision layer is taken away if timers out reset it, else advance timer
	if !get_collision_layer_value(1):
		if stunTimer <= 0:
			UnStunned()
		else:
			stunTimer -= delta * Globals.GameSpeed
		
		
	#after collision timer
	if stop:
		return
	#get directions from input and update velocity
	left = Input.is_action_pressed("left")
	right = Input.is_action_pressed("right")
	dir = int(right) - int (left)
	velocity = Vector2(dir,0) * speed
	# move and get collision, gamespeed for time manipulation
	var collision = move_and_collide(velocity*delta*Globals.GameSpeed)
	
	if Input.is_action_just_pressed("shoot"):
		if level != null:
			level.SpawnBall(ball_spawn_point.global_position)


# stop actions after collision / bounces were unpredicable without it, ball clipped into player
func BallCollision()->void:
	collision_timer.start()
	stop = 1

#stun player by taking away its collision layer and projectile masks, makes him unable to bounce blocks and be hit again
func IsStunned(time : float) -> void:
	sprites.set_modulate(Color(1,1,1,0.5)) 
	set_collision_layer_value(1, 0)
	set_collision_mask_value(4, 0)
	set_collision_mask_value(3, 0)
	stunTimer = time


#resets stun status
func UnStunned() -> void:
	sprites.set_modulate(Color(1,1,1,1)) 
	set_collision_layer_value(1, 1)
	set_collision_mask_value(4, 1)
	set_collision_mask_value(3, 1)
	stunTimer = 0

# after collision afk
func _on_collision_timer_timeout() -> void:
	stop = 0

func SetSize(size : float)->void:
	#change actual size
	collision_shape_2d.scale.y = size
	#change visual size
	sprites.scale.x = size

func SetMeterMax()->void:
	s_power_manager.SetMeterMax()
	
func SetMeterSpeed()->void:
	s_power_manager.SetMeterSpeed()

func SetMeterPower()->void:
	s_power_manager.SetMeterPower()
