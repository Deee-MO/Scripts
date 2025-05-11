extends Item

var timer : float = 0
var slowdown : bool = 0

func _process(delta: float) -> void:
	# if on timer, reduce it
	if timer > 0:
		timer -= delta
	#if time ran out and slowdown is active
	elif slowdown:
		#speed back up and turn off slowdown
		Globals.ChangeGameSpeedBy(1.5)
		slowdown = 0


func OnBallBounce(_ball:Ball, collider: Node)->void:
	#if hit paddle
	if collider is Player:
		#if not already in slowdown, slow time
		if !slowdown:
			Globals.ChangeGameSpeedBy(1./1.5)
		#reset timer, activate slowdown
		timer = 0.5
		slowdown = 1

func CheckFiltration() -> bool:
	for item in Globals.itemList.get_children():
		if item.id == id:
			FullItemList.FilterList[id] = FullItemList.Filter.None
			return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
