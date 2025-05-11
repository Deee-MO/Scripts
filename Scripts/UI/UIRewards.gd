extends Control

var rewardID1 : int = 0
@export var description1: Label
@export var option_1: NinePatchRect 

var rewardID2 : int = 0
@export var description2: Label 
@export var option_2: NinePatchRect

var rewardID3 : int = 0
@export var description3: Label
@export var option_3: NinePatchRect

var uiItemList : Control = null

func setRewards(number : int) -> void:
	if number < 1:
		return
	var rewardIds = FullItemList.GetRandXUniqueItems(number, FullItemList.Filter.Drop)
	rewardID1 = rewardIds[0]
	description1.text = load(FullItemList.List[rewardID1][0]).instantiate().description
	option_1.visible = 1 
	
	if number < 2:
		return
	rewardID2 = rewardIds[1]
	description2.text = load(FullItemList.List[rewardID2][0]).instantiate().description
	option_2.visible = 1 
	
	if number < 3:
		return
	rewardID3 = rewardIds[2]
	description3.text = load(FullItemList.List[rewardID3][0]).instantiate().description
	option_3.visible = 1 

func toggleVisibility() -> void:
	visible = !visible

func UpdateUIList(id : int) -> void:
	if uiItemList != null:
		await get_tree().create_timer(0.1).timeout 
		uiItemList.UpdateList()

func _on_option_1_button_pressed() -> void:
	FullItemList.ApplyItem(rewardID1)
	UpdateUIList(rewardID1)
	toggleVisibility()

func _on_option_2_button_pressed() -> void:
	FullItemList.ApplyItem(rewardID2)
	UpdateUIList(rewardID2)
	toggleVisibility()

func _on_option_3_button_pressed() -> void:
	FullItemList.ApplyItem(rewardID3)
	UpdateUIList(rewardID3)
	toggleVisibility()
