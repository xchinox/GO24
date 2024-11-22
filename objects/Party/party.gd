@tool 

class_name Party
extends Node3D

@onready var tank: Tank = get_node("Tank")
@onready var melee: Brigand = get_node("Brigand")
@onready var healer: Healer = get_node("Healer")
@onready var caster: Caster = get_node("Caster")
@onready var members: Array = [tank, melee, healer, caster]

signal unit_died
signal defeated

func _ready() -> void:
	tank.unit_died.connect(_on_unit_died)
	melee.unit_died.connect(_on_unit_died)
	healer.unit_died.connect(_on_unit_died)
	caster.unit_died.connect(_on_unit_died)

func tank_action(enemy_party: EnemyParty) -> void:
	tank.execute_action(self, enemy_party)

func melee_action(enemy_party: EnemyParty) -> void:
	melee.execute_action(self, enemy_party)

func healer_action(enemy_party: EnemyParty) -> void:
	healer.execute_action(self, enemy_party)
	
func caster_action(enemy_party: EnemyParty) -> void:
	caster.execute_action(self, enemy_party)
	
func _on_unit_died(unit: PlayerUnit) -> void:
	members.erase(unit)		
	unit.queue_free()
	unit_died.emit(unit.role)
	if members.size() == 0:
		defeated.emit()
