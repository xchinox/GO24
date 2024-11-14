class_name Caster
extends PlayerUnit


@onready var model: Node3D = get_node("Model")
@onready var anim_one: AnimationPlayer = model.get_node("AnimationPlayer")
@onready var anim_two: AnimationPlayer = model.get_node("AnimationPlayer")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	role = Role.RANGED
	health = max_health
	hp_bar = hp_bar_scene.instantiate()	
	add_child(hp_bar)	
	update_health_bar()


func execute_action(party: Party, enemy_party: EnemyParty) -> void:
	print("CASTER ACTION!", party)
	anim_one.play("rod_spin")
	anim_two.play("BézierCircleAction_002")
