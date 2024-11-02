extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var char_grid: CharacterGrid = CharacterGrid.new()

	for pos: Vector2 in char_grid.grid.keys():
		var label: Label = Label.new()
		label.text = char_grid.grid[pos]
		label.position = pos * 20
		add_child(label)
		
