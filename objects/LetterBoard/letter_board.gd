extends Node3D


enum InputState { IDLE, SELECT}
var state: InputState 


var selection: Array[CharacterModel]
var selection_letters: Array[String]
var char_grid: CharacterGrid = CharacterGrid.new()
func _ready() -> void:
	create_grid()

func create_grid() -> void:
	clear_grid()
	char_grid = CharacterGrid.new()	
	for pos: Vector2 in char_grid.grid.keys():
		var cm: CharacterModel = CharacterModel.new()
		cm.glyph = char_grid.grid[pos]
		cm.position = Vector3(pos.x, pos.y * -1, 0)
		cm.character_clicked.connect(_on_character_clicked)
		cm.mouse_entered.connect(_on_character_mouse_entered)
		add_child(cm)

func clear_grid() -> void:
	for child in get_children():
		if child is CharacterModel:
			child.queue_free()

func _on_button_pressed() -> void:
	create_grid()

func _on_character_clicked(cm: CharacterModel, event: InputEventMouseButton) -> void:
	if state != InputState.SELECT && event.button_mask == 1:
		change_state(InputState.SELECT)				
		selection_letters.append(cm.glyph)
		selection.append(cm)
		cm.toggle_emit(true)

func change_state(target_state: InputState) -> void:
	match target_state:
		InputState.IDLE: 
			if state == InputState.SELECT:
				evaluate_selection()
				print(selection)					
				print(selection_letters)			
				state = InputState.IDLE

		InputState.SELECT:
			state = InputState.SELECT

func _on_character_mouse_entered(cm: CharacterModel) -> void:
	if state == InputState.SELECT:
		selection.append(cm)
		selection_letters.append(cm.glyph)		
		cm.toggle_emit(true)


func evaluate_selection() -> void:
	var word: String = ""
	for letter in selection_letters:
		word += letter
	if word in char_grid.active_words:
		print("GOOD CHOICE")		
	else:
		for item in selection:
			item.toggle_emit(false)
	selection_letters.clear()
	selection.clear()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mevent := event as InputEventMouseButton
		if mevent.button_mask == 0: #Mouse button let go
			change_state(InputState.IDLE)
		
