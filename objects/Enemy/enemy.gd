class_name Enemy
extends Node3D


var max_health: int = 100
var health: int:
	set(value):
		if health + value <= 0:
			die()
		else:
			health = value
var level: int = 1
var shield: int = 0
var power: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func take_hit(amount: int) -> void:
	health -= amount
	print("DAMAGED: ", health)

func die() -> void:
	print("ARGH")
	queue_free()
