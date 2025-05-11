extends Node2D

const MAIN_MENU = ("res://Scenes/main_menu.tscn")

func _on_main_menu_pressed() -> void:
	Map.call_deferred(Map.NEXTSCENE, MAIN_MENU)
