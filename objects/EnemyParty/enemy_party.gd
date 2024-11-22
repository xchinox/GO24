@tool

class_name EnemyParty
extends Node3D


signal turn_complete
signal defeated


var hp_bar_scene: PackedScene = load("res://objects/PlayerUnit/HealthBar/health_bar.tscn")
var hp_bar: HealthBar = null
var ground_skeleton_scene: PackedScene = load("res://objects/Enemy/enemies/ground_skeleton.tscn")
var rat_scene: PackedScene = load("res://objects/Enemy/enemies/rat.tscn")
var members: Array[Enemy]

var enemy_order: int = 0

var target_party: Party 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_party()

func _on_action_complete() -> void:
	enemy_order += 1
	if enemy_order >= members.size():
		enemy_order = 0
		turn_complete.emit()
	else:
		members[enemy_order].execute_action(target_party)

func begin_turn(party: Party) -> void:	
	print("BEGIN TURN: ", members)
	target_party = party	
	members[enemy_order].execute_action(target_party)

func _on_unit_died(unit: Enemy) -> void:
	members.erase(unit)
	unit.queue_free()
	if members.size() == 0:
		defeated.emit()
		
func create_party() -> void:
	var skello: GroundSkeleton = ground_skeleton_scene.instantiate()
	var skellu: GroundSkeleton = ground_skeleton_scene.instantiate()
	var ratto: Rat = rat_scene.instantiate()

	skellu.position.y -= 8
	ratto.position.y -= 16

	skello.unit_died.connect(_on_unit_died)
	skellu.unit_died.connect(_on_unit_died)
	ratto.unit_died.connect(_on_unit_died)
	
	add_child(skello)
	add_child(skellu)
	add_child(ratto)

	
	members.append(skello)
	members.append(skellu)
	members.append(ratto)

	skello.action_complete.connect(_on_action_complete)
	skellu.action_complete.connect(_on_action_complete)
	ratto.action_complete.connect(_on_action_complete)

	
