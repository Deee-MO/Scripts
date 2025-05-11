extends NinePatchRect

@onready var description: Label = $VBoxContainer2/Description/Description
@onready var button: Button = $VBoxContainer2/OptionButton
@onready var costText: Label = $VBoxContainer2/OptionButton/Cost
@onready var insidebox: VBoxContainer = $VBoxContainer2

var shop: Node2D = null
var cost : float = 0
var id : int = 0

func SetItem(newid : int)->void:
	id = newid
	description.text = load(FullItemList.List[id][0]).instantiate().description
	SetCost(FullItemList.List[id][1] * 1000)

func SetCost(value : float) -> void:
	cost = value
	costText.text = str(int(value))

func _on_option_button_pressed() -> void:
	if cost > Globals.currency:
		return
	Globals.currency -= cost
	shop.uiright.setMoneyText()
	
	FullItemList.ApplyItem(id)
	insidebox.visible = 0
	
	if shop != null:
		shop.UpdateUIList()

