extends Item
#has 2 states, active when time is slower and inactive where nothing happens
#active is 2 seconds, inactive is 10 seconds

#start inactive
var timer : float = 10
var slowdown : bool = 0

var activated: bool = 0

func OnFirstBallShot(ball:Ball)->void:
	activated = 1

func _process(delta: float) -> void:
	#dont do anything if first ball hasnt been shot yet #also because its active outside levels
	if !activated:
		return
		
	timer -= delta
	#timer at 0
	if timer <= 0:
		#if was active
		if slowdown:
			#reset speed 
			Globals.ChangeGameSpeedBy(1.5)
			#reset timer 
			timer = 10
			slowdown = 0
		#if wasnt active
		else:
			#reset speed 
			Globals.ChangeGameSpeedBy(1./1.5)
			#reset timer 
			timer = 2
			slowdown = 1

func OnLevelEnd() -> void:
	#deactivate it to not mess with out of level stuff
	if slowdown:
		#reset timer 
		timer = 10
		slowdown = 0
	activated = 0

func CheckFiltration() -> bool:
	for item in Globals.itemList.get_children():
		if item.id == id:
			FullItemList.FilterList[id]  = FullItemList.Filter.None
			return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
