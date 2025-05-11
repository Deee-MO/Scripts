extends Level

const BREAKOUT_BLOCK_UNIDIRMOV = preload("res://Scenes/breakout_block_unidirmov.tscn")
var summonDir : Vector2 = Vector2(0,1)
var summonSpeed : float = 40
var summonTimer: float = 8
var nextSummonPool : int = 1
@onready var summon_timer: Timer = $SummonTimer

@onready var spawnpoints_1: Node = $Spawnpoints1
@onready var spawnpoints_2: Node = $Spawnpoints2

func _ready() -> void:
	#reset game speed
	Globals.ChangeGameSpeedBy(1./Globals.GameSpeed)
	#start boss music
	AudioManager.SwitchMusic(AudioManager.MUSIC.BOSS)
	uiright.ShowNextLevel()
	onready()


#function that triggers at actual level start = when first ball is shot
func LevelStart(ball:Ball)->void:
	uiright.toggleCross()
	levelStarted = 1
	for item:Item in Globals.itemList.get_children():
		if item.active: 
			item.OnFirstBallShot(ball)
	#start first summon timer
	summon_timer.start()

func _on_summon_timer_timeout() -> void:
	#spawn adds
	#take correct pool
	var pool = null
	if nextSummonPool == 1:
		pool = spawnpoints_1
	else:
		pool = spawnpoints_2
	#spawn on every point in pool
	for point in pool.get_children():
		var block: BreakoutBlock = BREAKOUT_BLOCK_UNIDIRMOV.instantiate()
		point.add_child(block)
		block.score = 0
		block.global_position = point.global_position
		block.dir = summonDir
		block.speed = summonSpeed
		block.health = 2
		block.ColorReset()
		
	#change spawn pool 2->1; 1->2
	nextSummonPool = 3 - nextSummonPool
	#speed up blocks and timer
	##blocks
	#timer
	summonTimer = 4 + (summonTimer - 4) * 0.8
	summon_timer.wait_time = summonTimer
	#reset timer
	summon_timer.start()

func OnStageClearSpecial()->void:
	spawnpoints_1.queue_free()
	spawnpoints_2.queue_free()
	summon_timer.queue_free()
	Globals.stage -= 1
	Globals.ballStartSpeed += 200
