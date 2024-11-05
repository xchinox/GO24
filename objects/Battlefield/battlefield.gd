class_name Battlefield
extends Node3D

@onready var shotclock: ShotClock = get_node("ShotClock")
@onready var letterboard: LetterBoard = get_node("LetterBoard")
@onready var hintlabels: HintLabels = get_node("HintLabels")

@onready var party: Party = get_node("Party")
@onready var enemy_party: EnemyParty = get_node("EnemyParty")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shotclock.crit_window_timeout.connect(_on_crit_window_timeout)
	shotclock.round_timout.connect(_on_round_timeout)
	letterboard.tank_action.connect(_on_tank_action)
	letterboard.melee_action.connect(_on_melee_action)
	set_words()
	
func _on_crit_window_timeout() -> void:
	hintlabels.visible = true

func set_words() -> void: 
	hintlabels.tank_text.text = letterboard.char_grid.active_words[0]
	hintlabels.melee_text.text = letterboard.char_grid.active_words[1]
	hintlabels.caster_text.text = letterboard.char_grid.active_words[2]
	hintlabels.healer_text.text = letterboard.char_grid.active_words[3]

func _on_round_timeout() -> void:
	print("ROUND OVER")


func _on_tank_action() -> void:
	party.tank_action()
			
			
func _on_melee_action() -> void:
	party.melee_action(enemy_party)
