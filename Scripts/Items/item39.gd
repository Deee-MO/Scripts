extends Item

var timer : float = 0
var speedup : bool = 0

func _process(delta: float) -> void:
	if Globals.player == null:
		return
	# if on timer, reduce it
	if timer > 0:
		timer -= delta
	#if time ran out and slowdown is active
	elif speedup:
		speedup = 0
		#speed back up and turn off slowdown
		Globals.player.speed *= 1/1.2


func OnBallBounce(_ball:Ball, collider: Node)->void:
	#if hit paddle
	if collider is Player:
		#if not already in slowdown, slow time
		if !speedup:
			Globals.player.speed *= 1.2
		#reset timer, activate slowdown
		timer = 0.5
		speedup = 1

func CheckFiltration() -> bool:
	for item in Globals.itemList.get_children():
		if item.id == id:
			FullItemList.FilterList[id] = FullItemList.Filter.None
			return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
