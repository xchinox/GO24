class_name HealthBar
extends Node3D

@onready var mesh_instance: MeshInstance3D = get_node("MeshInstance3D")

var total_hp: int = 0
var current_hp: int = 0


func _ready() -> void:
	
	pass # Replace with function body.


func set_text() -> void:
	var text_mesh: TextMesh = mesh_instance.mesh.duplicate()
	text_mesh.text = str(current_hp, "/", total_hp)
	mesh_instance.mesh = text_mesh
