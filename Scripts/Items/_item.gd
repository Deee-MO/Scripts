extends Node

class_name Item

@export var nickname: String 
@export var description : String
@export var id : int

var active : bool = true 
var held : bool = true

func _ready() -> void:
	pass

func OnFirstBallShot(_ball:Ball)->void:
	pass

func OnBallBounce(_ball:Ball, _collider: Node)->void:
	pass

func OnLevelStart(_level:Level)->void:
	pass

func OnPickUp()->void:
	pass

func OnRemoval()->void:
	pass

func OnLevelEnd() -> void:
	pass

func OnOvertime() -> void:
	pass
	
func OnShopEntered() -> void:
	pass

func OnBallShot(_ball:Ball) -> void:
	pass
	
func OnBallLost(_ball:Ball) -> void:
	pass

func CheckFiltration() -> bool:
	FullItemList.FilterList[id] = FullItemList.Filter.All
	return 1
