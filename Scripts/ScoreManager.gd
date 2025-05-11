extends Node

class_name ScoreManager

@onready var level: Level = $".."

var targetScore : float = 0
var curScore : float = 0
var overTime : bool = 0

func _ready() -> void:
	curScore = 0

func SetTargetScore(target:float) -> void:
	targetScore = target
	level.uileft.SetTargetScore(targetScore)

func UpdateScore(added:float) -> void:
	curScore += added
	level.uileft.SetCurrentScore(curScore)
	
	if curScore >= targetScore and !overTime:
		overTime = 1
		level.OvertimeStart()
	elif overTime:
		level.CheckOvertime()
