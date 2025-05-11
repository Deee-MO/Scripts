extends Item

const EMPTY_ITEM = 54

func _ready() -> void:
	held = 0

func OnPickUp()->void:
	#id here is id of self
	var item1: Item = load(FullItemList.List[EMPTY_ITEM][0]).instantiate()
	Globals.itemList.add_child(item1)
	
	var item2: Item = load(FullItemList.List[EMPTY_ITEM][0]).instantiate()
	Globals.itemList.add_child(item2)
	
	var item3: Item = load(FullItemList.List[EMPTY_ITEM][0]).instantiate()
	Globals.itemList.add_child(item3)


