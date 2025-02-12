extends Control

var stone_count = 0
var nail_count = 0
var wood_count = 0

func _ready():
	update_resource_counters()

func add_stone(amount):
	stone_count += amount
	update_resource_counters()
	
func add_nail(amount):
	nail_count += amount
	update_resource_counters()
	
func add_wood(amount):
	wood_count += amount
	update_resource_counters()

func update_resource_counters():
	$HBoxContainer/StoneCounter.text = str(stone_count)
	$HBoxContainer2/NailsCounter.text = str(nail_count)
	$HBoxContainer3/WoodCounter.text = str(wood_count)
