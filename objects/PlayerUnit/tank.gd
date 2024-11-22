class_name Tank
extends PlayerUnit

@onready var model: Node3D = get_node("Model")
@onready var anim: AnimationPlayer = model.get_node("AnimationPlayer")

var damage_reduction: float = .20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	role = Role.TANK	
	health = max_health
	hp_bar = hp_bar_scene.instantiate()	
	add_child(hp_bar)	
	update_health_bar()


func execute_action(party: Party, _enemy_party: EnemyParty) -> void:
	print("TANK ACTION!", party)

	var valid_members: Array[PlayerUnit]
	for member: PlayerUnit in party.members:
		if member.role != Role.TANK:
			valid_members.append(member)

	var target: PlayerUnit = valid_members.pick_random()
	target.is_protected = true
	target.tank_unit = self
	anim.play("Scale")
	NoiseManager.play_sfx("ImpactMining")

func intercede(ally: PlayerUnit) -> void:
	var origin: Vector3 = global_position
	var tween: Tween = get_tree().create_tween()	
	tween.tween_property(self, "global_position", ally.global_position, 0.1)
	tween.tween_property(self, "global_position", ally.global_position, 1.1)
	
	NoiseManager.play_sfx("ImpactMining")
	tween.chain().tween_property(self, "global_position", origin, 0.5)

func take_hit(amount: int, _source: Enemy) -> void:
	health -= amount - int(amount * damage_reduction)
