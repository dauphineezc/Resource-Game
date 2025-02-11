extends Control

var stone_count = 0
var wood_count = 0
var nail_count = 0

func _ready():
	update_resource_counters()

func add_stone(amount):
	stone_count += amount
	update_resource_counters()

func add_wood(amount):
	wood_count += amount
	update_resource_counters()

func add_nail(amount):
	nail_count += amount
	update_resource_counters()

func update_resource_counters():
	$ResourceBox/HBoxContainer/StoneCounter.text = str(stone_count)
	$ResourceBox/HBoxContainer2/WoodCounter.text = str(wood_count)
	$ResourceBox/HBoxContainer3/NailCounter.text = str(nail_count)
