class_name Enemy
extends Node3D

signal action_complete
signal unit_died

var max_health: int = 100
var health: int:
	set(value):		
		if value <= 0:
			die()
		else:
			health = value
		update_health_bar()

var level: int = 1
var shield: int = 0
var power: int = 1

var hp_bar_scene: PackedScene = load("res://objects/PlayerUnit/HealthBar/health_bar.tscn")
var hp_bar: HealthBar = null


func take_hit(amount: int) -> void:
	health -= amount
	

func die() -> void:		
	unit_died.emit(self)

func execute_action(_party: Party) -> void:
	pass

func signal_action_complete() -> void:
	action_complete.emit()

func update_health_bar() -> void:		
	if is_instance_valid(hp_bar):
		hp_bar.current_hp = health
		hp_bar.total_hp = max_health		
		hp_bar.set_text()

func is_high_health() -> bool:
	if int(health / max_health) * 100 > 80:
		return true
	else:
		return false

func is_low_health() -> bool:
	if int(health / max_health) * 100 < 20:
		return true
	else:
		return false
