extends Control

@onready var option1: NinePatchRect = $Options/VBoxContainer/HBoxContainer/Option
@onready var option2: NinePatchRect = $Options/VBoxContainer/HBoxContainer/Option2
@onready var option3: NinePatchRect = $Options/VBoxContainer/HBoxContainer/Option3
@onready var option4: NinePatchRect = $Options/VBoxContainer/HBoxContainer/Option4
@onready var option5: NinePatchRect = $Options/VBoxContainer/HBoxContainer2/Option
@onready var option6: NinePatchRect = $Options/VBoxContainer/HBoxContainer2/Option2
@onready var option7: NinePatchRect = $Options/VBoxContainer/HBoxContainer2/Option3
@onready var option8: NinePatchRect = $Options/VBoxContainer/HBoxContainer2/Option4
var options : Array = []
var count = 0
func _ready() -> void:
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
func AddItem(id) -> void:
	options[count].SetItem(id)
	options[count].visible = 1
	options[count].button.visible = 0
	count += 1
