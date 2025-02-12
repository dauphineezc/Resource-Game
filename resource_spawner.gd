extends Node2D

# Export variables to specify the number of each resource to spawn
@export var wood_count: int = 5
@export var stone_count: int = 5
@export var fence_count: int = 5

# Export variables to assign the resource scenes (assign in the Inspector)
@export var wood_scene: PackedScene
@export var stone_scene: PackedScene
@export var fence_scene: PackedScene

func _ready():
	# Get the viewport size (visible area of the game window)
	var viewport_size = get_viewport().get_visible_rect().size

	# Adjust the spawn boundaries based on the scene scale
	var adjusted_width = viewport_size.x / 0.075
	var adjusted_height = viewport_size.y / 0.075

	# Spawn multiple instances of each resource
	spawn_resources(wood_scene, wood_count, adjusted_width, adjusted_height)
	spawn_resources(stone_scene, stone_count, adjusted_width, adjusted_height)
	spawn_resources(fence_scene, fence_count, adjusted_width, adjusted_height)

func spawn_resources(resource_scene: PackedScene, count: int, width: float, height: float):
	for i in range(count):
		# Instantiate the resource scene
		var resource = resource_scene.instantiate()

		# Calculate random position within the adjusted bounds
		var padding = 1500  # Adjust as needed
		var random_x = randf_range(padding, width - padding)
		var random_y = randf_range(padding, height - padding)
		resource.position = Vector2(random_x, random_y)

		# Add the resource to the scene
		add_child(resource)
