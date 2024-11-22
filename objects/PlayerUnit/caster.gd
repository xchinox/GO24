class_name Caster
extends PlayerUnit


@onready var model: Node3D = get_node("Model")
@onready var anim_one: AnimationPlayer = model.get_node("AnimationPlayer")
@onready var anim_two: AnimationPlayer = model.get_node("AnimationPlayer")
@onready var explosion_scene: PackedScene = load("res://scenes/explosion_particles.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	role = Role.RANGED
	health = max_health
	hp_bar = hp_bar_scene.instantiate()	
	add_child(hp_bar)	
	update_health_bar()


func execute_action(_party: Party, enemy_party: EnemyParty) -> void:	
	anim_one.play("rod_spin")
	anim_two.play("BézierCircleAction_002")
	if !anim_one.animation_finished.is_connected(_on_animation_finished):		
		anim_one.animation_finished.connect(Callable(_on_animation_finished).bind(enemy_party))


func _on_animation_finished(_anim_name: StringName, enemy_party: EnemyParty) -> void:
	for member in enemy_party.members:		
		cast_explosion(member)
		member.take_hit(15)

func cast_explosion(enemy: Enemy) -> void: # -Megumin approved
	var particles: GPUParticles3D = explosion_scene.instantiate()	
	add_child(particles)
	NoiseManager.play_sfx("Explosion")
	NoiseManager.play_sfx("Firework")
	particles.global_position = enemy.global_position + Vector3(-2, .5, 1)
	particles.emitting = true
	particles.finished.connect(particles.queue_free)
