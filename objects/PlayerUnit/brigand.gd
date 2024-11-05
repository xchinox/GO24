class_name Brigand
extends Node3D



func execute_action(enemy_party: EnemyParty) -> void:
	print("MELEE ATTACK")
	for enemy in enemy_party.members:
		enemy.take_hit(500)
