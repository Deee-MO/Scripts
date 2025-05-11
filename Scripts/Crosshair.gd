extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func Hide()->void:
	sprite_2d.visible = 0
	
func Show()->void:
	sprite_2d.visible = 1
