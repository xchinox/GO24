class_name LetterBoard
extends Node3D


signal melee_action
signal tank_action
signal healer_action
signal caster_action
signal secret_action

enum InputState {IDLE, SELECT, DISABLED}
var state: InputState


var selection: Array[CharacterModel]
var selection_letters: Array[String]
var selection_direction: Array[Vector3] = []
var last_selected: Vector3
var allowed_actions: Array[Thesaurus.ActionType] = [Thesaurus.ActionType.DEFEND, Thesaurus.ActionType.ATTACK, Thesaurus.ActionType.SPELL, Thesaurus.ActionType.HEAL, Thesaurus.ActionType.SECRET]
var char_grid: CharacterGrid = CharacterGrid.new()
var char_model_grid: Dictionary
@onready var aplayer: AudioStreamPlayer = get_node("SelectionAudioStreamPlayer")

func _ready() -> void:
	CheatManager.cheat_request_highlight.connect(highlight_protected_cells)
	create_grid()

func create_grid() -> void:
	clear_grid()
	char_grid = CharacterGrid.new()	
	char_grid.allowed_actions = allowed_actions
	char_grid.initialize()

	for pos: Vector2 in char_grid.grid.keys():
		var cm: CharacterModel = CharacterModel.new()
		cm.glyph = char_grid.grid[pos]
		cm.position = Vector3(pos.x, pos.y * -1, 0)
		cm.character_clicked.connect(_on_character_clicked)
		cm.mouse_entered.connect(_on_character_mouse_entered)
		char_model_grid[pos] = cm
		add_child(cm)

func clear_grid() -> void:
	for child in get_children():
		if child is CharacterModel:
			child.queue_free()

func _on_button_pressed() -> void:
	create_grid()

func _on_character_clicked(cm: CharacterModel, event: InputEventMouseButton) -> void:
	if state == InputState.DISABLED:
		return
	if state != InputState.SELECT && event.button_mask == 1:
		change_state(InputState.SELECT)
		selection_letters.append(cm.glyph)
		selection.append(cm)
		selection_direction.append(cm.position)		
		cm.toggle_emit(true)		
		pitch_sound()

func _on_character_mouse_entered(cm: CharacterModel) -> void:
	if state == InputState.SELECT:		
		if selection_direction.size() < 2:
			#Check that we are adjacent to origin
			var diff: Vector3 = abs(cm.position - selection_direction[0])
			if diff.x <= 1 && diff.y <= 1:
				selection_direction.append(cm.position) # Add our second vector to determine allowed direction
				selection.append(cm)
				selection_letters.append(cm.glyph)
				cm.toggle_emit(true)
				last_selected = cm.position
				pitch_sound()
						
		else: #at this point we should have two vectors to determine a direction to lock into
			var dir: Vector3 = selection_direction[1] - selection_direction[0]
			var moved: Vector3 = cm.position - last_selected
			if dir == moved:
				last_selected = cm.position
				selection.append(cm)
				selection_letters.append(cm.glyph)
				cm.toggle_emit(true)
				pitch_sound()


func evaluate_selection() -> void:
	var selected_word: String = ""
	for letter in selection_letters:
		selected_word += letter
	
	var found: bool = false
	for active_word: CharacterGrid.ActiveWord in char_grid.active_words:
		if active_word.word == selected_word:
			emit_signal_by_role(active_word.action_type)
			found = true
	if !found:
		NoiseManager.play_sfx("Error")
		for item in selection:#Turn off the selection glow for specified character
			if is_instance_valid(item):
				item.toggle_emit(false)
	else:
		pass
	selection_letters.clear()
	selection.clear()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mevent := event as InputEventMouseButton
		if mevent.button_mask == 0: # Mouse button let go
			change_state(InputState.IDLE)
		
func emit_signal_by_role(type: Thesaurus.ActionType) -> void:	
	match type:
		Thesaurus.ActionType.ATTACK:
			melee_action.emit()
		Thesaurus.ActionType.DEFEND:
			tank_action.emit()
		Thesaurus.ActionType.HEAL:
			healer_action.emit()
		Thesaurus.ActionType.SPELL:
			caster_action.emit()
		Thesaurus.ActionType.SECRET:
			secret_action.emit()

func change_state(target_state: InputState) -> void:
	match target_state:
		InputState.IDLE:
			if state == InputState.SELECT:
				evaluate_selection()
				selection_direction.clear()
				aplayer.pitch_scale = 1.0
				state = InputState.IDLE

			if state == InputState.DISABLED:
				state = InputState.IDLE

		InputState.SELECT:
			state = InputState.SELECT

		InputState.DISABLED:			
			state = InputState.DISABLED

func pitch_sound() -> void:
	print("PITCH", selection_letters.size() * .1)
	aplayer.pitch_scale += selection_letters.size() * .1
	aplayer.play()

func highlight_protected_cells() -> void:
	for cell in char_grid.protected_cells:
		var cm: CharacterModel = char_model_grid[cell]
		cm.toggle_emit(true)
		
	await get_tree().create_timer(3).timeout
	for cell in char_grid.protected_cells:
		var cm: CharacterModel = char_model_grid[cell]
		cm.toggle_emit(false)
