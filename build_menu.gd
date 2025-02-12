extends Control

# Resource costs by category
var resource_costs = {
	"Roads": {"stone": 1},
	"Fences": {"wood": 1},
	"Decor": {"wood": 1, "nails": 1},
	"Buildings": {"stone": 2, "wood": 2, "nails": 2}
}

# Map grid containers to asset folders
var grids_to_folders = {
	"TabContainer/Roads/GridContainer": "res://assets/Roads",
	"TabContainer/Fences/GridContainer2": "res://assets/Fences",
	"TabContainer/Nature/GridContainer3": "res://assets/Nature",
	"TabContainer/Decor/GridContainer4": "res://assets/Decor",
	"TabContainer/Buildings/GridContainer5": "res://assets/Buildings"
}

# Member variable for UI elements
var is_open = false

# Signal to notify that an asset was selected
signal asset_selected(asset_path, position)

func _ready():
	hide()  # Start with the menu hidden
	populate_grids()
	$ToggleMenu.connect("pressed", Callable(self, "toggle_menu"))

func populate_grids():
	# Iterate over the keys (grid node paths) in the dictionary.
	for grid_path in grids_to_folders.keys():
		var folder_path = grids_to_folders[grid_path]
		populate_grid(grid_path, folder_path)

func populate_grid(grid_path, folder_path):
	var grid = get_node(grid_path)
	# Open the folder using DirAccess (Godot 4)
	var dir = DirAccess.open(folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png"):
				var button = TextureButton.new()
				button.texture_normal = load(folder_path + "/" + file_name)
				grid.add_child(button)
				var cb = Callable(self, "_on_TextureButton_pressed").bind(folder_path + "/" + file_name, grid.get_parent().get_name())
				button.connect("pressed", cb)
				file_name = dir.get_next()
		dir.list_dir_end()

func toggle_menu():
	is_open = !is_open
	if is_open:
		show()
	else:
		hide()

func open_at_position(position):
	# Set the position and show the menu
	set("rect_position", position)
	show()
	is_open = true

func close_menu():
	hide()
	is_open = false

func has_enough_resources(category):
	for resource in resource_costs[category].keys():
		var amount = resource_costs[category][resource]
		if $UI/ResourceBox.get_resource_count(resource) < amount:
			return false
	return true

func subtract_resources(category):
	for resource in resource_costs[category].keys():
		var amount = resource_costs[category][resource]
		$UI/ResourceBox.subtract_resource(resource, amount)

func _on_TextureButton_pressed(asset_path, category):
	if has_enough_resources(category):
		subtract_resources(category)
		var map_position = get_map_position_from_mouse_click()
		emit_signal("asset_selected", asset_path, map_position)
	else:
		show_error("Not enough resources!")

func show_error(message):
	$ErrorMessage.text = message
	$ErrorMessage.popup_centered()

func get_map_position_from_mouse_click() -> Vector2:
	return get_viewport().get_mouse_position()
