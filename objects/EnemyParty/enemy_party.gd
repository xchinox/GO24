class_name EnemyParty
extends Node3D


var ground_skeleton_scene: PackedScene = load("res://objects/Enemy/enemies/ground_skeleton.tscn")
var members: Array[Enemy]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var skello: GroundSkeleton = ground_skeleton_scene.instantiate()
	add_child(skello)
	members.append(skello)
	

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
