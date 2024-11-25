class_name Battlefield
extends Node3D

@onready var shotclock: ShotClock = get_node("ShotClock")
@onready var letterboard: LetterBoard = get_node("LetterBoard")
@onready var hintlabels: HintLabels = get_node("HintLabels")
@onready var button: Button = get_node("EndTurnButton")
@onready var party: Party = get_node("Party")
@onready var enemy_party: EnemyParty = get_node("EnemyParty")
@onready var victory: Node3D = get_node("VictoryFanfare")
@onready var defeat_fanfare: Node3D = get_node("DefeatFanfare")
@onready var secret_handler: SecretWordHandler = get_node("SecretWordHandler")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shotclock.crit_window_timeout.connect(_on_crit_window_timeout)
	shotclock.round_timout.connect(_on_round_timeout)
	letterboard.tank_action.connect(_on_tank_action)
	letterboard.melee_action.connect(_on_melee_action)
	letterboard.healer_action.connect(_on_healer_action)
	letterboard.caster_action.connect(_on_caster_action)
	letterboard.secret_action.connect(_on_secret_action)
	enemy_party.turn_complete.connect(_on_enemy_turn_complete)
	enemy_party.defeated.connect(_on_enemy_party_defeated)
	party.unit_died.connect(_on_unit_died)
	party.defeated.connect(_on_party_defeated)
	begin_round()
	
func _on_crit_window_timeout() -> void:
	hintlabels.visible = true

func set_words() -> void:
	hintlabels.clear()
	for active_word in letterboard.char_grid.active_words:
		match active_word.action_type:
			Thesaurus.ActionType.DEFEND:
				hintlabels.tank_text.text = active_word.word
			Thesaurus.ActionType.ATTACK:
				hintlabels.melee_text.text = active_word.word
			Thesaurus.ActionType.SPELL:
				hintlabels.caster_text.text = active_word.word
			Thesaurus.ActionType.HEAL:
				hintlabels.healer_text.text = active_word.word		
		
		
func _on_round_timeout() -> void:
	letterboard.change_state(LetterBoard.InputState.DISABLED)
	enemy_party.begin_turn(party)

func _on_tank_action() -> void:
	party.tank_action(enemy_party)
			
			
func _on_melee_action() -> void:
	party.melee_action(enemy_party)

func _on_end_turn_button_pressed() -> void:
	shotclock.round_timer.stop()
	_on_round_timeout()

func _on_healer_action() -> void:
	party.healer_action(enemy_party)

func _on_caster_action() -> void:
	party.caster_action(enemy_party)

func _on_secret_action() -> void:
	secret_handler.execute_action(party, enemy_party, shotclock)

func _on_enemy_turn_complete() -> void:
	shotclock.reset()
	letterboard.change_state(LetterBoard.InputState.IDLE)
	letterboard.create_grid()
	begin_round()

func _on_unit_died(unit: PlayerUnit.Role) -> void:		
	match unit:
		PlayerUnit.Role.TANK:								
			letterboard.allowed_actions.erase(Thesaurus.ActionType.DEFEND)			
		PlayerUnit.Role.MELEE:
			letterboard.allowed_actions.erase(Thesaurus.ActionType.ATTACK)
		PlayerUnit.Role.RANGED:
			letterboard.allowed_actions.erase(Thesaurus.ActionType.SPELL)
		PlayerUnit.Role.HEAL:
			letterboard.allowed_actions.erase(Thesaurus.ActionType.HEAL)
	

func begin_round() -> void:
	set_words()

func _on_enemy_party_defeated() -> void:	
	button.text = "Continue"
	button.pressed.disconnect(_on_end_turn_button_pressed)
	button.pressed.connect(_on_continue_button_pressed)
	victory.visible = true
	shotclock.round_timer.paused = true

func _on_continue_button_pressed() -> void:
	print("Continue")

func _on_party_defeated() -> void:
	button.text = "Retreat"
	button.pressed.disconnect(_on_end_turn_button_pressed)
	button.pressed.connect(_on_continue_button_pressed)
	defeat_fanfare.visible = true
	shotclock.round_timer.paused = true
