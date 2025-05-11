extends Level

@onready var cannon: Node2D = $Blocks/BreakoutBlock25/ProjectileSpawner
@onready var crosshair: Node2D = $Crosshair

var projectileSpeed : float = 600
var cannonTimer: float = 0
var nextCannonTimer : float = 2
var crosshairMovement : bool = 1

func _ready() -> void:
	#reset game speed
	Globals.ChangeGameSpeedBy(1./Globals.GameSpeed)
	#start boss music
	AudioManager.SwitchMusic(AudioManager.MUSIC.BOSS)
	
	crosshair.Hide()
	uiright.ShowNextLevel()
	onready()

func _process(delta: float) -> void:
	#if the cannon is broken hide crosshair
	if !cannon:
		crosshair.Hide()
		return
	#if crosshair movement isnt locked track player
	if crosshairMovement:
		crosshair.global_position = player.global_position
	
	if levelStarted:
		levelTimer += delta
		#if cannon timer ran out, set it really high to not trigger it again and shoot
		if cannonTimer <= 0:
			cannonTimer = 999
			CannnonFire()
			return
		#else advance cannontimer
		cannonTimer -= delta * Globals.GameSpeed
		

#function that triggers at actual level start = when first ball is shot
func LevelStart(ball:Ball)->void:
	uiright.toggleCross()
	levelStarted = 1
	for item:Item in Globals.itemList.get_children():
		if item.active: 
			item.OnFirstBallShot(ball)
	#start first summon timer
	cannonTimer = nextCannonTimer


func CannnonFire() -> void:
	#crosshair blinking before shot
	crosshair.Show()
	await get_tree().create_timer(0.125).timeout
	if !cannon:
		crosshair.Hide()
		return
	crosshair.Hide()
	await get_tree().create_timer(0.125).timeout
	if !cannon:
		crosshair.Hide()
		return
	crosshair.Show()
	await get_tree().create_timer(0.125).timeout
	if !cannon:
		crosshair.Hide()
		return
	crosshair.Hide()
	await get_tree().create_timer(0.125).timeout
	if !cannon:
		crosshair.Hide()
		return
	crosshair.Show()
	#lock the shot on current player position and shoot in half a second
	crosshairMovement = 0
	var at = player.global_position
	await get_tree().create_timer(0.25).timeout
	if !cannon:
		crosshair.Hide()
		return
	crosshair.Hide()
	crosshairMovement = 1
	#shoot cannon 3 times
	cannon.Fire(projectileSpeed, at)
	await get_tree().create_timer(0.125).timeout
	if !cannon:
		return
	cannon.Fire(projectileSpeed, at)
	await get_tree().create_timer(0.125).timeout
	if !cannon:
		return
	cannon.Fire(projectileSpeed, at)
	#speed up timer
	nextCannonTimer = 0.5 + (nextCannonTimer - 0.5) * 0.8
	#start timer
	cannonTimer = nextCannonTimer

func OnStageClearSpecial()->void:
	Globals.stage -= 1
	Globals.ballStartSpeed += 200
