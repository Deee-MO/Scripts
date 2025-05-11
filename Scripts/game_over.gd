extends Node2D

@onready var score: Label = $Results/MarginContainer/NinePatchRect/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/Score/Number
@onready var time: Label = $Results/MarginContainer/NinePatchRect/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/Time/Number


func _ready() -> void:
	#remove items in case they affect game speed
	for item in Globals.itemList.get_children():
		item.queue_free()
	#reset game speed
	Globals.ChangeGameSpeedBy(1./Globals.GameSpeed)
	AudioManager.SwitchMusic(AudioManager.MUSIC.SHOP)
	AudioManager.PlaySound(AudioManager.SOUND.GAMEOVER)

	score.text = str(int(Globals.overallScore))
	var seconds : int = int(Globals.overallTime)
	time.text = str(seconds/60) + ":" 
	seconds = seconds %60
	if seconds < 10:
		time.text += "0"
	time.text += str(seconds)

func _on_main_menu_button_pressed() -> void:
	Globals.Reset()
	Map.LoadMainMenu()


func _on_restart_button_pressed() -> void:
	Globals.Reset()
	Globals.stage = 1
	
	#testing purposes
	Testing.OnStartGame()
	
	Map.LoadNext(Globals.stage)
