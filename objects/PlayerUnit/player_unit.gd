class_name PlayerUnit
extends Node3D


enum Role { TANK, MELEE, RANGED, HEAL}

var role: Role = Role.TANK

var max_health: int = 1000
var health: int  = max_health
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.s
