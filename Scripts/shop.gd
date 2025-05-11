extends Node2D

@onready var uiright: Control = $Control/Right
@onready var option1: NinePatchRect = $Control/Shop/NinePatchRect/VBoxContainer/Options/VBoxContainer/HBoxContainer/Option
@onready var option2: NinePatchRect = $Control/Shop/NinePatchRect/VBoxContainer/Options/VBoxContainer/HBoxContainer/Option2
@onready var option3: NinePatchRect = $Control/Shop/NinePatchRect/VBoxContainer/Options/VBoxContainer/HBoxContainer/Option3
@onready var option4: NinePatchRect = $Control/Shop/NinePatchRect/VBoxContainer/Options/VBoxContainer/HBoxContainer/Option4
@onready var option5: NinePatchRect = $Control/Shop/NinePatchRect/VBoxContainer/Options/VBoxContainer/HBoxContainer2/Option
@onready var option6: NinePatchRect = $Control/Shop/NinePatchRect/VBoxContainer/Options/VBoxContainer/HBoxContainer2/Option2
@onready var option7: NinePatchRect = $Control/Shop/NinePatchRect/VBoxContainer/Options/VBoxContainer/HBoxContainer2/Option3
@onready var option8: NinePatchRect = $Control/Shop/NinePatchRect/VBoxContainer/Options/VBoxContainer/HBoxContainer2/Option4
var options : Array = []
var healItem : bool 

func _ready() -> void:
	#reset game speed
	Globals.ChangeGameSpeedBy(1./Globals.GameSpeed)
	#start shop music
	AudioManager.SwitchMusic(AudioManager.MUSIC.SHOP)
	
	for item:Item in Globals.itemList.get_children():
		if item.active: 
			item.OnShopEntered()
	
	healItem = Globals.playerHealth < Globals.playerMaxHealth
	
	options = [
		option1,
		option2,
		option3,
		option4,
		option5,
		option6,
		option7,
		option8
	]
	option1.shop = self
	option2.shop = self
	option3.shop = self
	option4.shop = self
	option5.shop = self
	option6.shop = self
	option7.shop = self
	option8.shop = self
	uiright.ShowNextLevel()
	uiright.setStageText()
	uiright.setMoneyText()
	uiright.toggleNext()
	
	#load items, get prices from rarity and show descriptions with prices
	var itemIds = FullItemList.GetRandXUniqueItems(8, FullItemList.Filter.Shop)
	var assigned : int = 8
	if healItem:
		options[7].SetItem(20)
		assigned = 7
	for number in range(assigned):
		options[number].SetItem(itemIds[number])

func UpdateUIList()-> void:
	await get_tree().create_timer(0.1).timeout 
	uiright.items_window.UpdateList()


