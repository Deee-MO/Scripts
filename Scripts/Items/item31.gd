extends Item

var leftTime : float = 0.
var rightTime : float = 0.
var inDashTime : float = 0.
var dashDir : int = 0

var player : Player = null


func OnLevelStart(_level:Level)->void:
	player = Globals.player

func OnLevelEnd() -> void:
	player = null


func _process(delta: float) -> void:
	#if outside level
	if player == null:
		return
	#if not in dash
	if dashDir == 0:
		#advance timers
		if leftTime > 0:
			leftTime -= delta
		if rightTime > 0:
			rightTime -= delta
		
		# if direction was pressed
		if Input.is_action_just_pressed("left"):
			# shortly after previous press
			if leftTime > 0:
				#assign dash direction
				dashDir = -1
				#assign dash time
				inDashTime = 0.1
				#reset prev input time
				leftTime = 0
				#stop player from interfering
				player.stop = 1
			#if not shortly after previous press
			else:
				# null other direction timer
				# give this direction a timer
				rightTime = 0
				leftTime = 0.3
		# same as left
		if Input.is_action_just_pressed("right"):
			if rightTime > 0:
				dashDir = 1
				inDashTime = 0.1
				rightTime = 0
				player.stop = 1
			else:
				rightTime = 0.3
				leftTime = 0

	#if in dash
	else:
		# if time ran out
		if inDashTime <= 0:
			#reset dash dir and allow player to move
			dashDir = 0
			player.stop = 0
			return
		#advance time
		inDashTime -= delta
		#move player in direction at 2.5 times speed
		player.velocity = Vector2(dashDir,0) * player.speed * 3
		player.move_and_collide(player.velocity*delta*Globals.GameSpeed)

func CheckFiltration() -> bool:
	for item in Globals.itemList.get_children():
		if item.id == id:
			FullItemList.FilterList[id] = FullItemList.Filter.None
			return 0
	FullItemList.FilterList[id] = FullItemList.Filter.All
	return 1
