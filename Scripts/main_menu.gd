extends Node2D

@onready var uiright: Control = $Control/Right
@onready var quit: MarginContainer = $Control/Right/Quit
@onready var default: MarginContainer = $Control/Right/Default

func _ready() -> void:
	#reset game speed
	Globals.ChangeGameSpeedBy(1./Globals.GameSpeed)
	#start main menu music
	AudioManager.SwitchMusic(AudioManager.MUSIC.SHOP)
	
	uiright.upgrades_button.disabled = 1
	uiright.quit_button.disabled = 1
	uiright.tips_button.disabled = 1
	uiright.settings_button.disabled = 1


func _on_start_button_pressed() -> void:
	Globals.Reset()
	Globals.stage = 1
	
	#testing purposes
	Testing.OnStartGame()
	
	Map.LoadNext(Globals.stage)

func toggleVisibility(rightMenu: MarginContainer) -> void:
	uiright.toggleVisibility(rightMenu)
	if rightMenu == uiright.quit:
		uiright.toggleVisibility(rightMenu)
		quit.visible = !quit.visible
		default.visible= !quit.visible
	else:
		default.visible = uiright.default.visible
		quit.visible = 0





func _on_quit_button_pressed() -> void:
	toggleVisibility(uiright.quit)

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_tips_button_pressed() -> void:
	toggleVisibility(uiright.tips)

func _on_settings_button_pressed() -> void:
	uiright.sound.visible = 0
	uiright.video.visible = 0
	toggleVisibility(uiright.settings)
