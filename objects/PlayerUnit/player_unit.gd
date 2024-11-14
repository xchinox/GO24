class_name PlayerUnit
extends Node3D


signal unit_died


enum Role { TANK, MELEE, RANGED, HEAL}

var role: Role = Role.TANK
var max_health: int = 100
var hp_bar_scene: PackedScene = load("res://objects/PlayerUnit/HealthBar/health_bar.tscn")
var hp_bar: HealthBar = null

var is_protected: bool = false
var tank_unit: Tank

var health: int:
	set(value):
		print("health value: ", value)
		if value < 1:			
			die()						
		else:
			health = value
		update_health_bar()
		print(health)
	
func _ready() -> void:
	pass
	

func take_hit(amount: int, source: Enemy) -> void:	
	if is_protected && is_instance_valid(tank_unit):
		tank_unit.intercede(self)
		tank_unit.take_hit(amount, source)
		is_protected = false
	else:
		health -= amount
	

func die() -> void:
	print("UNIT DIED, HEALTH: ", self, health)
	unit_died.emit(self)

func execute_action(_party: Party, _enemy_party: EnemyParty) -> void:
	pass


func update_health_bar() -> void:		
	if is_instance_valid(hp_bar):
		hp_bar.current_hp = health
		hp_bar.total_hp = max_health		
		hp_bar.set_text()
