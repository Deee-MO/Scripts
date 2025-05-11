extends Node

enum Rarity{
	COMMON = 1,
	RARE = 2,
	EPIC = 3,
	LEGEND = 4
}

enum Filter{
	All = 1,
	Shop = 2,
	Drop = 3,
	None = 4
}

var RarityLists : Dictionary = {
	Rarity.COMMON : Array([], TYPE_INT, "", null),
	Rarity.RARE : Array([], TYPE_INT, "", null),
	Rarity.EPIC : Array([], TYPE_INT, "", null),
	Rarity.LEGEND : Array([], TYPE_INT, "", null),
}

var FilterList : Dictionary

#list assigning ids to scenes
const List = {
	1 : ["res://Scenes/Items/item1.tscn", Rarity.EPIC], 
	2 : ["res://Scenes/Items/item2.tscn", Rarity.COMMON], 
	3 : ["res://Scenes/Items/item3.tscn", Rarity.RARE], 
	4 : ["res://Scenes/Items/item4.tscn", Rarity.COMMON],
	5 : ["res://Scenes/Items/item5.tscn", Rarity.COMMON], 
	6 : ["res://Scenes/Items/item6.tscn", Rarity.COMMON], 
	7 : ["res://Scenes/Items/item7.tscn", Rarity.RARE],
	8 : ["res://Scenes/Items/item8.tscn", Rarity.COMMON], 
	9 : ["res://Scenes/Items/item9.tscn", Rarity.COMMON],
	10 : ["res://Scenes/Items/item10.tscn", Rarity.EPIC], 
	11 : ["res://Scenes/Items/item11.tscn", Rarity.RARE],
	12 : ["res://Scenes/Items/item12.tscn", Rarity.COMMON],
	13 : ["res://Scenes/Items/item13.tscn", Rarity.EPIC], 
	14 : ["res://Scenes/Items/item14.tscn", Rarity.COMMON], 
	15 : ["res://Scenes/Items/item15.tscn", Rarity.COMMON],
	16 : ["res://Scenes/Items/item16.tscn", Rarity.RARE],
	17 : ["res://Scenes/Items/item17.tscn", Rarity.RARE],
	18 : ["res://Scenes/Items/item18.tscn", Rarity.EPIC], 
	19 : ["res://Scenes/Items/item19.tscn", Rarity.COMMON], 
	20 : ["res://Scenes/Items/item20.tscn", Rarity.COMMON], 
	21 : ["res://Scenes/Items/item21.tscn", Rarity.RARE],
	22 : ["res://Scenes/Items/item22.tscn", Rarity.RARE], 
	23 : ["res://Scenes/Items/item23.tscn", Rarity.EPIC], 
	24 : ["res://Scenes/Items/item24.tscn", Rarity.RARE], 
	25 : ["res://Scenes/Items/item25.tscn", Rarity.LEGEND],
	26 : ["res://Scenes/Items/item26.tscn", Rarity.RARE], 
	27 : ["res://Scenes/Items/item27.tscn", Rarity.COMMON], 
	28 : ["res://Scenes/Items/item28.tscn", Rarity.RARE], 
	29 : ["res://Scenes/Items/item29.tscn", Rarity.EPIC], 
	30 : ["res://Scenes/Items/item30.tscn", Rarity.RARE],
	31 : ["res://Scenes/Items/item31.tscn", Rarity.LEGEND],
	32 : ["res://Scenes/Items/item32.tscn", Rarity.COMMON], 
	33 : ["res://Scenes/Items/item33.tscn", Rarity.COMMON],
	34 : ["res://Scenes/Items/item34.tscn", Rarity.RARE], 
	35 : ["res://Scenes/Items/item35.tscn", Rarity.COMMON],
	36 : ["res://Scenes/Items/item36.tscn", Rarity.COMMON], 
	37 : ["res://Scenes/Items/item37.tscn", Rarity.EPIC],
	38 : ["res://Scenes/Items/item38.tscn", Rarity.COMMON],
	39 : ["res://Scenes/Items/item39.tscn", Rarity.COMMON],
	40 : ["res://Scenes/Items/item40.tscn", Rarity.RARE],
	41 : ["res://Scenes/Items/item41.tscn", Rarity.RARE],
	42 : ["res://Scenes/Items/item42.tscn", Rarity.COMMON],
	43 : ["res://Scenes/Items/item43.tscn", Rarity.COMMON],
	44 : ["res://Scenes/Items/item44.tscn", Rarity.EPIC],
	45 : ["res://Scenes/Items/item45.tscn", Rarity.EPIC],
	46 : ["res://Scenes/Items/item46.tscn", Rarity.COMMON],
	47 : ["res://Scenes/Items/item47.tscn", Rarity.RARE],
	48 : ["res://Scenes/Items/item48.tscn", Rarity.RARE],
	49 : ["res://Scenes/Items/item49.tscn", Rarity.LEGEND],
	50 : ["res://Scenes/Items/item50.tscn", Rarity.RARE],
	51 : ["res://Scenes/Items/item51.tscn", Rarity.RARE],
	52 : ["res://Scenes/Items/item52.tscn", Rarity.LEGEND],
	53 : ["res://Scenes/Items/item53.tscn", Rarity.COMMON],
	54 : ["res://Scenes/Items/item54.tscn", Rarity.COMMON],
}

func _ready() -> void:
	#fill rarity list ids, list[id][1] is rarity value
	for id in List:
		RarityLists[List[id][1]].append(id)
		FilterList[id] = Filter.All
		
	#print(Rarity.COMMON,"  ---  ", RarityLists[Rarity.COMMON].size())
	#print(Rarity.RARE,"  ---  ", RarityLists[Rarity.RARE].size())
	#print(Rarity.EPIC,"  ---  ", RarityLists[Rarity.EPIC].size())
	#print(Rarity.LEGEND,"  ---  ", RarityLists[Rarity.LEGEND].size())
	

func GetRandXUniqueItems(amount : int, filter : int) -> Array[int]:
	var common:int = 0
	var rare:int = 0
	var epic:int = 0
	var legend:int = 0
	#assign rarity to each item drop
	for i in range(amount):
		#probability system 
		var rand = randi_range(1,100)
		if rand < 60:
			#common 59/100
			common += 1
		elif rand < 90:
			#rare 30/100
			rare += 1
		elif rand < 100:
			#epic 10/100
			epic += 1
		else:
			#legend 1/100
			legend += 1
			
	
	var ids:Array[int] = []
	ids += GetRandXUniqueItemsOfRarity(common, Rarity.COMMON, filter)
	ids += GetRandXUniqueItemsOfRarity(rare, Rarity.RARE, filter)
	ids += GetRandXUniqueItemsOfRarity(epic, Rarity.EPIC, filter)
	ids += GetRandXUniqueItemsOfRarity(legend, Rarity.LEGEND, filter)
	ids.shuffle()
	return ids

#returns ids of random unique selected items
##edit for item availability restrictions 
func GetRandXUniqueItemsOfRarity(amount : int, rarity : int, filter : int) -> Array[int]:
	var ids: Array[int] = []
	#make unique ids array
	var uniqueIds : Array[int] = RarityLists[rarity].duplicate()
	#filter(all and drop for uniques)
	var toErase : Array[int] = []
	for id in uniqueIds:
		if FilterList[id] not in [Filter.All, filter]:
			toErase.append(id)
	for id in toErase:
		uniqueIds.erase(id)
	
	for i in range(amount):
		#from unique array pick random
		var gotit : bool = 0
		while (!gotit):
			var id = uniqueIds.pick_random()
			var item: Item = load(List[id][0]).instantiate()
			if item.CheckFiltration():
				gotit = 1
				#remove that from uniques array
				uniqueIds.erase(id)
				ids.append(id)
				item.queue_free()
			else:
				uniqueIds.erase(id)
				item.queue_free()
	return ids

func ApplyItem(id : int)->void:
	#load by id from full list
	var item: Item = load(List[id][0]).instantiate()
	item._ready()
	if item.held:
		Globals.itemList.add_child(item)
		item.OnPickUp()
	
	else:
		item.OnPickUp()
		await get_tree().create_timer(0.1).timeout 
		item.queue_free()

func RemoveItem(item:Item)->void:
	item.OnRemoval()
	item.queue_free()

