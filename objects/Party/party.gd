class_name Party
extends Node3D

@onready var tank: Tank = get_node("Tank")
@onready var melee: Brigand = get_node("Brigand")


func tank_action() -> void:
	tank.execute_action()

func melee_action(enemy_party: EnemyParty) -> void:
	melee.execute_action(enemy_party)

	
