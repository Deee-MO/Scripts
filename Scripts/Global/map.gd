extends Node

const SHOP = "res://Scenes/shop.tscn"
const GAME_OVER = "res://Scenes/game_over.tscn"
const MAIN_MENU = "res://Scenes/main_menu.tscn"

#lists with levels for each progression stage
const List = {
	1 : {
		1 : "res://Scenes/levels/level1-1.tscn",
		2 : "res://Scenes/levels/level1-2.tscn",
		3 : "res://Scenes/levels/level1-3.tscn",
	},
	2 : {
		1 : "res://Scenes/levels/level2-1.tscn",
		2 : "res://Scenes/levels/level2-2.tscn",
		3 : "res://Scenes/levels/level2-3.tscn",
	},
	3 : {
		1 : "res://Scenes/levels/level3-1.tscn",
		2 : "res://Scenes/levels/level3-2.tscn",
		3 : "res://Scenes/levels/level3-3.tscn",
	},
	4 : {
		1 : "res://Scenes/levels/level4-1.tscn",
		2 : "res://Scenes/levels/level4-2.tscn",
		3 : "res://Scenes/levels/level4-3.tscn",
	},
	5 : {
		1 : "res://Scenes/levels/level5-wall.tscn",
		2 : "res://Scenes/levels/level5-cannon.tscn"
	},
	6 : {
		1 : "res://Scenes/levels/level6-1.tscn",
		2 : "res://Scenes/levels/level6-2.tscn",
	},
	7 : {
		1 : "res://Scenes/levels/level7-1.tscn",
		2 : "res://Scenes/levels/level7-2.tscn",
	},
	8 : {
		1 : "res://Scenes/levels/level8-1.tscn",
		2 : "res://Scenes/levels/level8-2.tscn",
	},
	9 : {
		1 : "res://Scenes/levels/level9-1.tscn",
	},
	10 : {
		1 : "res://Scenes/levels/level10-wall.tscn",
		2 : "res://Scenes/levels/level10-cannon.tscn"
	},
}

#returns next random level address given progression stage
func GetRandLevel(stage : int) -> String:
	var id = randi_range(1, List[stage].size())
	return List[stage][id]



const NEXTSCENE : String = "loadNextScene"
const NEXTSCENEPACKED : String = "loadNextScenePacked"
func loadNextScene(scene : String) -> void:
	get_tree().change_scene_to_file(scene)
	return
func loadNextScenePacked(scene : PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)
	return

func LoadShop() -> void:
	Globals.ResetFiltration()
	Globals.level = null
	call_deferred(NEXTSCENE, SHOP)

func LoadNext(stage : int)->void:
	##this loads first stage and ups the difficulty(extra block health) 
	##when no more stages, above 5 now
	if stage > 10:
		Globals.difficulty += 2
		Globals.stage = 6
		stage = 6
	
	Globals.ResetFiltration()
	Globals.level = null
	var nextScene = GetRandLevel(stage)
	call_deferred(NEXTSCENE, nextScene)
	return
	
	
func LoadGameOver()->void:
	call_deferred(NEXTSCENE, GAME_OVER)

func LoadMainMenu()->void:
	call_deferred(NEXTSCENE, MAIN_MENU)
