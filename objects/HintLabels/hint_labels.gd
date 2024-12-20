class_name HintLabels
extends Node3D

@onready var tank_label: MeshInstance3D = get_node("TankWord")
@onready var tank_text: TextMesh = tank_label.mesh

@onready var melee_label: MeshInstance3D = get_node("MeleeWord")
@onready var melee_text: TextMesh = melee_label.mesh

@onready var caster_label: MeshInstance3D = get_node("CasterWord")
@onready var caster_text: TextMesh = caster_label.mesh

@onready var healer_label: MeshInstance3D = get_node("HealerWord")
@onready var healer_text: TextMesh = healer_label.mesh
# Called when the node enters the scene tree for the first time.





func clear() -> void:
	tank_text.text = ""
	melee_text.text = ""
	caster_text.text = ""
	healer_text.text = ""
