extends Control

var targetNumber : float 

@onready var target_number: Label = $NinePatchRect/RightUI/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/TextNumbers/VBoxContainer/Target/ScoreNumber
@onready var cur_number: Label = $NinePatchRect/RightUI/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/TextNumbers/VBoxContainer/Current/CurNumber

@onready var moving_separator: Control = $NinePatchRect/RightUI/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/Meter/MarginContainer/HBoxContainer/VBoxContainer/MovingSeparator
@onready var bar: TextureProgressBar = $NinePatchRect/RightUI/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/Meter/MarginContainer/HBoxContainer/MarginContainer/SPBar
@onready var number: Label = $NinePatchRect/RightUI/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/Meter/MarginContainer/HBoxContainer/VBoxContainer/Number
@onready var line: HSeparator = $NinePatchRect/RightUI/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/Meter/MarginContainer/HBoxContainer/VBoxContainer/Line


func SetTargetScore(score:float) -> void:
	targetNumber = score
	target_number.text = str(int(score))

func SetCurrentScore(score:float) ->void:
	if score > targetNumber:
		target_number.text = "OVERTIME"
	if score > targetNumber * 1.4:
		line.visible = 0
		number.visible = 0
	cur_number.text = str(int(score))
	number.text = str(int(score))
	bar.value = (score * 75) / targetNumber
	moving_separator.custom_minimum_size.y = (score * 100) / targetNumber
