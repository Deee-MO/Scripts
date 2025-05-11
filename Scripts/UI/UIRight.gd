extends Control

#menus
@onready var default: MarginContainer = $InRight/RightUI/Top/NinePatchRect/Default
@onready var next_default: MarginContainer = $InRight/RightUI/Top/NinePatchRect/NextDefault
var next : bool = 0
@onready var upgrades: MarginContainer = $InRight/RightUI/Top/NinePatchRect/Upgrades
@onready var settings: MarginContainer = $InRight/RightUI/Top/NinePatchRect/Settings
@onready var tips: MarginContainer = $InRight/RightUI/Top/NinePatchRect/Tips
@onready var quit: MarginContainer = $InRight/RightUI/Top/NinePatchRect/Quit
#track open menu
var curMenu : MarginContainer

#bottom buttons
@onready var upgrades_button: Button = $InRight/RightUI/Bottom/NinePatchRect/Buttons/TopButtons/UpgradesButton
@onready var settings_button: Button = $InRight/RightUI/Bottom/NinePatchRect/Buttons/TopButtons/SettingsButton
@onready var tips_button: Button = $InRight/RightUI/Bottom/NinePatchRect/Buttons/BottomButtons/TipsButton
@onready var quit_button: Button = $InRight/RightUI/Bottom/NinePatchRect/Buttons/BottomButtons/QuitButton

#next buttons
@onready var next_level_button: Button = $InRight/RightUI/Top/NinePatchRect/NextDefault/VBoxContainer/Buttons/MarginContainer/VBoxContainer/NextLevelButton
@onready var shop_button: Button = $InRight/RightUI/Top/NinePatchRect/NextDefault/VBoxContainer/Buttons/MarginContainer/VBoxContainer/ShopButton
@onready var other_button: Button = $InRight/RightUI/Top/NinePatchRect/NextDefault/VBoxContainer/Buttons/MarginContainer/VBoxContainer/OtherButton

@onready var cross: NinePatchRect = $InRight/RightUI/Bottom/NinePatchRect/Cross
var inplay : bool = 0

func _ready() -> void:
	curMenu = default
	default.visible = 1
	next_default.visible = 0
	settings.visible = 0
	upgrades.visible = 0
	tips.visible = 0
	quit.visible = 0
	
	musicBus = AudioServer.get_bus_index(MUSIC_AUDIO_BUS)
	sfxBus = AudioServer.get_bus_index(SFX_AUDIO_BUS)
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(musicBus))
	music_number.text = str(music_slider.value * 100) + "%"
	sound_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfxBus))
	sound_number.text = str(sound_slider.value * 100) + "%"

func ShowShop() ->void:
	if (Globals.stage + 1) % 5 != 0:
		shop_button.visible = 1
func ShowNextLevel()-> void:
	next_level_button.visible = !next_level_button.visible

func toggleVisibility(menu : MarginContainer) -> void:
	items_window.visible = 0
	tips_menus.visible = 0
	#if menu isnt visible, display it and hide current
	if !menu.visible:
		menu.visible = 1
		curMenu.visible = 0
		curMenu = menu
	#if visible, hide it, show default
	else:
		menu.visible = 0
		if !next:
			default.visible = 1
			curMenu = default
		else:
			next_default.visible = 1
			curMenu = next_default

func toggleNext() -> void:
	if curMenu != next_default:
		curMenu.visible = 0
	next_default.visible = 1
	curMenu = next_default
	next = 1


func toggleCross() -> void:	
	if curMenu != default:
		curMenu.visible = 0
		default.visible = 1
		curMenu = default
	inplay = !inplay
	cross.visible = inplay
	settings_button.disabled = inplay
	upgrades_button.disabled = inplay
	tips_button.disabled = inplay
	quit_button.disabled = inplay


##Default menu

@onready var stage_text2: Label = $InRight/RightUI/Top/NinePatchRect/NextDefault/VBoxContainer/Stage/StageText
@onready var stage_text: Label = $InRight/RightUI/Top/NinePatchRect/Default/VBoxContainer/Stage/StageText
const STAGETEXTBASE = "Stage: "
func setStageText() -> void:
	stage_text.text = STAGETEXTBASE + str(Globals.stage)
	stage_text2.text = STAGETEXTBASE + str(Globals.stage)
	
@onready var money_text2: Label = $InRight/RightUI/Top/NinePatchRect/NextDefault/VBoxContainer/Money/MoneyText
@onready var money_text: Label = $InRight/RightUI/Top/NinePatchRect/Default/VBoxContainer/Money/MoneyText
const MONEYTEXTBASE = "Money: "
func setMoneyText() -> void:
	money_text.text = MONEYTEXTBASE + str(Globals.currency)
	money_text2.text = MONEYTEXTBASE + str(Globals.currency)

@onready var held_number: Label = $InRight/RightUI/Top/NinePatchRect/Default/VBoxContainer/BallCount/VBoxContainer/HBoxContainer2/HeldNumber
@onready var shot_number: Label = $InRight/RightUI/Top/NinePatchRect/Default/VBoxContainer/BallCount/VBoxContainer/HBoxContainer2/ShotNumber
func setBallsHeld(count : int) -> void:
	held_number.text = str(count)
func setBallsField(count : int) -> void:
	shot_number.text = str(count)

@onready var sp_bar: TextureProgressBar = $InRight/RightUI/Top/NinePatchRect/Default/VBoxContainer/SPower/MarginContainer/HBoxContainer/SPBar
@onready var current_meter: Label = $InRight/RightUI/Top/NinePatchRect/Default/VBoxContainer/SPower/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/CurrentMeter
@onready var max_meter: Label = $InRight/RightUI/Top/NinePatchRect/Default/VBoxContainer/SPower/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/MaxMeter
func setMaxMeter() -> void:
	max_meter.text = str(Globals.meterMax)
func setCurMeter(value : float) -> void:
	value = max(value, 0)
	current_meter.text = str(int(value))
	sp_bar.value = (value*100) / Globals.meterMax


##Quit Menu
@onready var confirmation: NinePatchRect = $InRight/RightUI/Top/NinePatchRect/Quit/VBoxContainer/QuitMenu/MarginContainer/HBoxContainer/Confirmation

##Upgrades Menu
@onready var items_window: Control = $InRight/RightUI/Top/NinePatchRect/Upgrades/ItemsWindow


##Settings
@onready var sound: MarginContainer = $InRight/RightUI/Top/NinePatchRect/Settings/VBoxContainer/Menu/Sound
@onready var video: MarginContainer = $InRight/RightUI/Top/NinePatchRect/Settings/VBoxContainer/Menu/Video

@onready var sound_number: Label = $InRight/RightUI/Top/NinePatchRect/Settings/VBoxContainer/Menu/Sound/VBoxContainer/SoundNumber
@onready var music_number: Label = $InRight/RightUI/Top/NinePatchRect/Settings/VBoxContainer/Menu/Sound/VBoxContainer/MusicNumber
@onready var sound_slider: HSlider = $InRight/RightUI/Top/NinePatchRect/Settings/VBoxContainer/Menu/Sound/VBoxContainer/SoundSlider
@onready var music_slider: HSlider = $InRight/RightUI/Top/NinePatchRect/Settings/VBoxContainer/Menu/Sound/VBoxContainer/MusicSlider

@onready var resolution_button: Button = $InRight/RightUI/Top/NinePatchRect/Settings/VBoxContainer/Menu/Video/VBoxContainer/ResolutionButton
@onready var resolution_text: Label = $InRight/RightUI/Top/NinePatchRect/Settings/VBoxContainer/Menu/Video/VBoxContainer/ResolutionButton/Text
@onready var fullscreenx: Label = $InRight/RightUI/Top/NinePatchRect/Settings/VBoxContainer/Menu/Video/VBoxContainer/FullScreen/FullscreenButton/X
@onready var vsyncx: Label = $InRight/RightUI/Top/NinePatchRect/Settings/VBoxContainer/Menu/Video/VBoxContainer/VSync/VSyncButton/X

const SFX_AUDIO_BUS = "sfx"
const MUSIC_AUDIO_BUS = "Music"
var sfxBus : int
var musicBus : int

const ResolutionIndexes: Array = [
	Vector2i(640,360),
	Vector2i(854,480),  
	Vector2i(960,540),
	Vector2i(1024,576), 
	Vector2i(1152,648),
	Vector2i(1280,720),
	Vector2i(1366,768),
	Vector2i(1600,900),
	Vector2i(1920,1080)
]
const Resolutions: Dictionary = {
	Vector2i(640,360)   : "640x360",
	Vector2i(854,480)   : "854x480",
	Vector2i(960,540)   : "960x540",
	Vector2i(1024,576)  : "1024x576",
	Vector2i(1152,648)  : "1152x648",
	Vector2i(1280,720)  : "1280x720",
	Vector2i(1366,768)  : "1366x768",
	Vector2i(1600,900)  : "1600x900",
	Vector2i(1920,1080) : "1920x1080",
}
var resolutionShown : int
var fullscreenShown : bool
var vsyncShown : bool

##Tips
@onready var tips_menus: Control = $InRight/RightUI/Top/NinePatchRect/Tips/TipsMenus
@onready var controlsmenu: MarginContainer = $InRight/RightUI/Top/NinePatchRect/Tips/TipsMenus/MarginContainer/NinePatchRect/Controls
@onready var tutorialmenu: MarginContainer = $InRight/RightUI/Top/NinePatchRect/Tips/TipsMenus/MarginContainer/NinePatchRect/Tutorial
@onready var tipsmenu: MarginContainer = $InRight/RightUI/Top/NinePatchRect/Tips/TipsMenus/MarginContainer/NinePatchRect/Tips


##buttons
func _on_upgrades_button_pressed() -> void:
	toggleVisibility(upgrades)

func _on_settings_button_pressed() -> void:
	sound.visible = 0
	video.visible = 0
	toggleVisibility(settings)

func _on_tips_button_pressed() -> void:
	toggleVisibility(tips)

func _on_quit_button_pressed() -> void:
	confirmation.visible = 0
	toggleVisibility(quit)

##NextDefault
func _on_next_level_button_pressed() -> void:
	Globals.stage += 1
	Map.LoadNext(Globals.stage)

func _on_shop_button_pressed() -> void:
	Globals.stage += 1
	Map.LoadShop() 

func _on_other_button_pressed() -> void:
	pass 

##Settings
func _on_sound_pressed() -> void:
	sound.visible = !sound.visible
	video.visible = 0

func _on_video_pressed() -> void:
	video.visible = !video.visible
	sound.visible = 0
	resolutionShown = ResolutionIndexes.find(get_window().get_size())
	fullscreenShown = get_window().get_mode() == Window.MODE_FULLSCREEN
	vsyncShown = DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED
	
	resolution_button.disabled = fullscreenShown
	var incolor : float = 1 - (int(fullscreenShown) * 0.5)
	resolution_text.modulate = Color(incolor,incolor,incolor)
	resolution_text.text = Resolutions[ResolutionIndexes[resolutionShown]]
	fullscreenx.visible = fullscreenShown
	vsyncx.visible = vsyncShown

func _on_resolution_button_pressed() -> void:
	resolutionShown += 1
	if resolutionShown == ResolutionIndexes.size():
		resolutionShown = 0
	resolution_text.text = Resolutions[ResolutionIndexes[resolutionShown]]

func _on_fullscreen_button_pressed() -> void:
	fullscreenShown = !fullscreenShown
	fullscreenx.visible = fullscreenShown
	resolution_button.disabled = fullscreenShown
	var incolor : float = 1 - (int(fullscreenShown) * 0.5)
	resolution_text.modulate = Color(incolor,incolor,incolor)

func _on_v_sync_button_pressed() -> void:
	vsyncShown = !vsyncShown
	vsyncx.visible = vsyncShown

func _on_apply_button_pressed() -> void:
	#resolution
	get_window().set_size(ResolutionIndexes[resolutionShown])
	var centre = DisplayServer.screen_get_position()+DisplayServer.screen_get_size()/2
	get_window().set_position(centre - ResolutionIndexes[resolutionShown]/2)
	#fullscreen
	if fullscreenShown:
		get_window().set_mode(Window.MODE_FULLSCREEN)
	else:
		get_window().set_mode(Window.MODE_WINDOWED)
	#vsync
	if vsyncShown:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	pass

func _on_sound_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		sfxBus,
		linear_to_db(value)
	)
	sound_number.text = str(value * 100) + "%"

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		musicBus,
		linear_to_db(value)
	)
	music_number.text = str(value * 100) + "%"


##Quit
func _on_abandon_button_pressed() -> void:
	confirmation.visible = !confirmation.visible
	
func _on_game_over_button_pressed() -> void:
	Map.LoadGameOver()

##Upgrades
func _on_item_list_pressed() -> void:
	items_window.visible = !items_window.visible
	items_window.Open()


##Tips
func _on_controls_pressed() -> void:
	tips_menus.visible = 1
	controlsmenu.visible = 1
	tutorialmenu.visible = 0
	tipsmenu.visible = 0

func _on_tutorial_pressed() -> void:
	tips_menus.visible = 1
	controlsmenu.visible = 0
	tutorialmenu.visible = 1
	tipsmenu.visible = 0

func _on_tips_pressed() -> void:
	tips_menus.visible = 1
	controlsmenu.visible = 0
	tutorialmenu.visible = 0
	tipsmenu.visible = 1
