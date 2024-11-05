class_name Tank
extends PlayerUnit

@onready var model: Node3D = get_node("Model")
@onready var anim: AnimationPlayer = model.get_node("AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func execute_action() -> void:
	print("Ok!")
	anim.play("Scale")
