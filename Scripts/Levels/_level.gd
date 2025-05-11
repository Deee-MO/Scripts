extends Node2D

class_name Level

const NEXTSCENE : String = "loadNextScene"
const NEXTSCENEPACKED : String = "loadNextScenePacked"
func loadNextScene(scene : String) -> void:
	get_tree().change_scene_to_file(scene)
	return
func loadNextScenePacked(scene : PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)
	return
func LoadNext()->void:
	var nextIndex = randi_range(1, 1)
	var nextScene = ""
	match nextIndex:
		1:
			nextScene = "res://Scenes/levels/_level_breakout.tscn"
		2:
			nextScene = "res://Scenes/levels/_level_obstacle.tscn"
		3:
			nextScene = "res://Scenes/levels/_level_pong.tscn"
	call_deferred(NEXTSCENE, nextScene)
	return


@export var enemyHealth : int = 1

@onready var player: Player = $Player
@onready var balls: Node = $Balls
@onready var blocks: Node = $Blocks
@onready var score_manager: ScoreManager = $ScoreManager
@onready var overtime_timer: Timer = $OvertimeTimer

#ui elements
@onready var uiright: Control = $UI/Right
@onready var uirewards: Control = $UI/Rewards
@onready var uileft: Control = $UI/Left

#timer
var levelTimer : float = 0.

# artifact from previous ball spawn idea
const BALLSCENE : PackedScene = preload("res://Scenes/ball.tscn")
var levelStarted : bool = 0

func _ready() -> void:
	#reset game speed
	Globals.ChangeGameSpeedBy(1./Globals.GameSpeed)
	#start level music
	AudioManager.SwitchMusic(AudioManager.MUSIC.MAIN)
	onready()
	

func onready() -> void:
	#set this level in player script and globals
	player.level = self
	Globals.level = self
	#increase block health according to difficulty
	for block: BreakoutBlock in blocks.get_children():
		block.health += Globals.difficulty
		block.ColorReset()
	
	# calculate target score for this level
	var totalScore = 0
	for block: BreakoutBlock in blocks.get_children():
		totalScore += (block.health * block.score)
	# pass target score to score manager
	score_manager.SetTargetScore(totalScore)
	
	#trigger items
	for item:Item in Globals.itemList.get_children():
		if item.active: 
			item.OnLevelStart(self)
			
	#UIs
	uirewards.uiItemList = uiright.items_window
	uirewards.setRewards(3)
	uiright.ShowNextLevel()
	uiright.setStageText()
	uiright.setMaxMeter()
	uiright.setMoneyText()
	uiright.ShowShop()
	uiright.setBallsHeld(Globals.playerHealth)
	uiright.setBallsField(0)

func _process(delta: float) -> void:
	if levelStarted:
		levelTimer += delta

#function that triggers at actual level start = when first ball is shot
func LevelStart(ball:Ball)->void:
	uiright.toggleCross()
	levelStarted = 1
	for item:Item in Globals.itemList.get_children():
		if item.active: 
			item.OnFirstBallShot(ball)
	
func SpawnBall(ball_spawn_point: Vector2, recoverable : bool = 1)-> void:
	if recoverable:
		if Globals.playerHealth <= 0: 
			return
		Globals.ChangeLife(-1)
		
	#spawn it
	var ball: CharacterBody2D = BALLSCENE.instantiate()
	balls.add_child(ball)
	if !recoverable:
		ball.SetRecoverable(0)
	#set its position on players spawn point
	ball.position = ball_spawn_point
	# set balls level
	ball.level = self
	#add a little random x scew
	var initialRandDir = Vector2(randi_range(-10,10), -100).normalized()
	#assign it initial direction (forward + player direction and movement speed) and set velocity using its speed
	ball.velocity = (initialRandDir + Vector2(player.dir,0)).normalized() * ball.speed
	for item:Item in Globals.itemList.get_children():
		if item.active: 
			item.OnBallShot(ball)
	if !levelStarted:
		LevelStart(ball)
	uiright.setBallsField(balls.get_child_count())

#on players zone entered
func _on_damage_zone_body_entered(body: Node2D) -> void:
	if body is Ball:
		for item:Item in Globals.itemList.get_children():
			if item.active: 
				item.OnBallLost(body)
		AudioManager.PlaySound(AudioManager.SOUND.BALLLOST)
		
	body.queue_free()
	await body.tree_exited
	
	#get number of recoverable balls and fake objects(preventing death) on field
	var recoverableCount : int = 0
	var fakes : int = 0
	for object in balls.get_children():
		if object is Ball:
			if object.recoverable:
				recoverableCount += 1
		else:
			fakes += 1
	
	#update ui excluding fakes
	uiright.setBallsField(balls.get_child_count() - fakes)
	
	if !(Globals.playerHealth > 0 or recoverableCount + fakes > 0):
		#player loses
		Globals.overallScore += score_manager.curScore
		Globals.overallTime += levelTimer
		Map.LoadGameOver()

func _on_damage_zone_2_body_entered(body: Node2D) -> void:
	##wip
	enemyHealth -= 1
	Globals.ChangeLife(1)
	body.queue_free()
	
	#if stage cleared
	if enemyHealth <= 0:
		StageCleared()

func OvertimeStart() -> void:
	#trigger items, then timer
	for item:Item in Globals.itemList.get_children():
		if item.active: 
			item.OnOvertime()
	#add time here to not include overtime
	Globals.overallTime += levelTimer
	#start overtime if needed
	if blocks.get_child_count() > 0:
		AudioManager.PlaySound(AudioManager.SOUND.OVERTIME)
		#start overtime
		overtime_timer.wait_time = Globals.overtimeTime
		overtime_timer.start()
	else:
		_on_overtime_timer_timeout()

func CheckOvertime() -> void:
	#score manager calls it when score is added to see of there is anything to break
	if blocks.get_child_count() == 0:
		overtime_timer.stop()
		_on_overtime_timer_timeout()

func BallBounce(ball:Ball, collider: Node) -> void:
	for item:Item in Globals.itemList.get_children():
		if item.active: 
			item.OnBallBounce(ball, collider)

func StageCleared() -> void:
	##wip
	AudioManager.PlaySound(AudioManager.SOUND.LEVELCLEAR)
	#items
	for item:Item in Globals.itemList.get_children():
		if item.active: 
			item.OnLevelEnd()
	
	uiright.toggleCross()
	uiright.toggleNext()
	
	#stop balls player and blocks
	for block in blocks.get_children():
		block.queue_free()
	#destroy all current balls
	for ball in balls.get_children():
		#if ball is valid restore it
		if ball is Ball:
			if ball.recoverable:
				Globals.ChangeLife(1)
		ball.queue_free()
	uiright.setBallsField(0)
	#disconect level from player to stop him from spawning new balls
	player.level = null
	#special end of stage events for bosses
	OnStageClearSpecial()
	#activate reward option buttons
	uirewards.toggleVisibility()

func OnStageClearSpecial()->void:
	pass

func _on_overtime_timer_timeout() -> void:
	#get extra accumulated score
	var overtimeCurrency = score_manager.curScore - score_manager.targetScore
	#calculate score to currency(double required score doubles level currency(1000) - proportional)
	overtimeCurrency *= (1000/score_manager.targetScore)
	#add score and money to globals
	var baseRewardMoney = 1000
	#if boss stage, double normal reward
	if Globals.stage % 5 == 0:
		baseRewardMoney = 2000
	Globals.currency += baseRewardMoney + int(overtimeCurrency)
	Globals.overallScore += score_manager.curScore
	uiright.setMoneyText()
	StageCleared()



