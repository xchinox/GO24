extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_grid()

func create_grid() -> void:
	clear_grid()
	var char_grid: CharacterGrid = CharacterGrid.new()
	for pos: Vector2 in char_grid.grid.keys():
		var cm: CharacterModel = CharacterModel.new()
		cm.glyph = char_grid.grid[pos]
		cm.position = Vector3(pos.x, pos.y * -1, 0)
		add_child(cm)

func clear_grid() -> void:
	for child in get_children():
		if child is CharacterModel:
			child.queue_free()

func _on_button_pressed() -> void:
	create_grid()
