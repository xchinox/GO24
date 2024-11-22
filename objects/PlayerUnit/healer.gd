class_name Healer 
extends PlayerUnit


@onready var anim_player: AnimationPlayer = get_node("Model/AnimationPlayer")
var hparticle_scene: PackedScene = load("res://scenes/heal_particles.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	role = Role.HEAL
	health = max_health
	hp_bar = hp_bar_scene.instantiate()	
	add_child(hp_bar)	
	update_health_bar()
	
func execute_action(party: Party, enemy_party: EnemyParty) -> void:
	var target: PlayerUnit = null
	for member: PlayerUnit in party.members:
		if target == null:
			target = member
		else:
			if member.health < target.health:
				target = member
		
	
	anim_player.play("rod_spin")
	var hparticle: GPUParticles3D = hparticle_scene.instantiate()
	
	add_child(hparticle)
	hparticle.global_position = target.global_position + Vector3(.5, 0, 0)
	hparticle.emitting = true	
	hparticle.finished.connect(hparticle.queue_free)
	
	target.health += GameVal.heal_amount
	NoiseManager.play_sfx("VoxChord")
	
	

 
