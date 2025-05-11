extends Control

const UI_ITEM_LIST_PAGE = preload("res://Scenes/UI/uiItemList.tscn")

@onready var list: MarginContainer = $MarginContainer/NinePatchRect/VBoxContainer/List
@onready var next_p_button: Button = $MarginContainer/NinePatchRect/VBoxContainer/HBoxContainer/MarginContainer2/NextPButton
@onready var prev_p_button: Button = $MarginContainer/NinePatchRect/VBoxContainer/HBoxContainer/MarginContainer/PrevPButton

var pages : Array
var curPage : int = -1

func _ready() -> void:
	next_p_button.visible = 0
	prev_p_button.visible = 0
	var page : Control = null
	var count = 0
	if Globals.itemList.get_child_count() == 0:
		var newpage: Control = UI_ITEM_LIST_PAGE.instantiate()
		list.add_child(newpage)
		pages.resize(1)
		pages[curPage] = newpage
		
	for item:Item in Globals.itemList.get_children():
		count += 1
		if count == 9:
			count = 1
		if count == 1:
			curPage += 1
			var newpage: Control = UI_ITEM_LIST_PAGE.instantiate()
			list.add_child(newpage)
			page = newpage
			page.visible = 0
			pages.resize(curPage + 1)
			pages[curPage] = page
		page.AddItem(item.id)

func Open() -> void:
	if pages.size() != 0:
		pages[curPage].visible = 0
		curPage = 0
		pages[curPage].visible = 1
		prev_p_button.visible = 0
		if pages.size() > 1:
			next_p_button.visible = 1
	
func UpdateList() -> void:
	for page in pages:
		page.queue_free()
	pages.resize(0)
	curPage = -1
	_ready()

func _on_next_p_button_pressed() -> void:
	pages[curPage].visible = 0
	curPage += 1
	pages[curPage].visible = 1
	if curPage + 1 == pages.size():
		next_p_button.visible = 0
	if curPage != 0:
		prev_p_button.visible = 1

func _on_prev_p_button_pressed() -> void:
	pages[curPage].visible = 0
	curPage -= 1
	pages[curPage].visible = 1
	if curPage + 1 != pages.size():
		next_p_button.visible = 1
	if curPage == 0:
		prev_p_button.visible = 0
