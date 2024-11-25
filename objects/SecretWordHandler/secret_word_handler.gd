class_name SecretWordHandler
extends Node3D


var party: Party
var enemy_party: EnemyParty
var shotclock: ShotClock
enum Action { HEAL, CRITHEAL, DAMAGE, CRITDAMAGE, TIME, CRITTIME }
var available_actions: Array[Action] = [
	Action.HEAL,
	Action.CRITHEAL,
	Action.DAMAGE,
	Action.CRITDAMAGE,
	Action.TIME,
	Action.CRITTIME
]
var hparticle_scene: PackedScene = load("res://scenes/heal_particles.tscn")

@onready var plus_model: Node3D = get_node("medical_plus")
@onready var sword_model: Node3D = get_node("sword")
@onready var clock_model: Node3D = get_node("clock")
@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

@onready var models: Array[Node3D]  = [plus_model, sword_model, clock_model]

var show_duration: float = 0.25
var anim_names: Array[StringName] = ["clock_visibility", "plus_visibility", "sword_visibility" ]
var action: Action

func execute_action(_party: Party, _enemy_party: EnemyParty, _shotclock: ShotClock) -> void:
	enemy_party = _enemy_party
	party = _party
	shotclock = _shotclock
	if anim_player.animation_changed.is_connected(_on_animation_changed):
		anim_player.animation_changed.disconnect(_on_animation_changed)
	if anim_player.animation_finished.is_connected(_on_animation_finished):	
		anim_player.animation_finished.disconnect(_on_animation_finished)
	anim_player.animation_changed.connect(_on_animation_changed)	
	anim_player.animation_finished.connect(_on_animation_finished)

	shotclock.round_timer.paused = true
	NoiseManager.play_sfx("Tick")
	var qidx: int = 0
	for i in range(0,10):
		print("QING")
		anim_player.queue(anim_names[qidx] as StringName)
		qidx += 1
		if qidx >= anim_names.size():
			qidx = 0

	party = _party
	enemy_party = _enemy_party
	action = available_actions.pick_random()
	
	
	match action:
		Action.HEAL:
			anim_player.queue("plus_visibility")
			
				

		Action.CRITHEAL:
			anim_player.queue("plus_visibility")
				
		Action.DAMAGE:				
			anim_player.queue("sword_visibility")
			

		Action.CRITDAMAGE:
			anim_player.queue("sword_visibility")
		Action.TIME:			
			anim_player.queue("clock_visibility")
			
		Action.CRITTIME:			
			anim_player.queue("clock_visibility")
			
		
			

func _on_animation_changed(oldname: StringName, newname: StringName) -> void:
	print("Q: ", anim_player.get_queue())
	NoiseManager.play_sfx("Tick")

func _on_animation_finished(name: StringName) -> void:
	print("ANIMATION_FINISHED")
	match action:
		Action.HEAL:
			heal_action()
		Action.CRITHEAL:
			crit_heal_action()
		Action.DAMAGE:
			damage_action()
		Action.CRITDAMAGE:
			crit_damage_action()
		Action.TIME:
			time_action()
		Action.CRITTIME:
			crit_damage_action()

func heal_action() -> void:
	NoiseManager.play_sfx("VoxChord")
	for member: PlayerUnit in party.members:		
		member.health += GameVal.heal_amount
		var hparticle: GPUParticles3D = hparticle_scene.instantiate()	
		add_child(hparticle)
		hparticle.global_position = member.global_position + Vector3(.5, 0, 0)
		hparticle.emitting = true	
		hparticle.finished.connect(hparticle.queue_free)
	shotclock.round_timer.paused = false
		
func crit_heal_action() -> void:
	NoiseManager.play_sfx("VoxChord")
	for member: PlayerUnit in party.members:
		member.health += GameVal.heal_amount + int(GameVal.heal_amount * .5)
		var hparticle: GPUParticles3D = hparticle_scene.instantiate()	
		add_child(hparticle)
		hparticle.global_position = member.global_position + Vector3(.5, 0, 0)
		hparticle.emitting = true	
		hparticle.finished.connect(hparticle.queue_free)
	shotclock.round_timer.paused = false
	
func damage_action() -> void:
	for member: Enemy in enemy_party.members:
				member.take_hit(int(member.health * .5))
	shotclock.round_timer.paused = false
		
func crit_damage_action() -> void:	
	for member: Enemy in enemy_party.members:
		member.take_hit(int(member.health * .75))
	shotclock.round_timer.paused = false

func time_action() -> void:
	shotclock.round_timer.paused = true
	shotclock.round_timer.set_wait_time(shotclock.round_timer.wait_time + 15)			
	shotclock.round_timer.paused = false 
func crit_time_action() -> void:
	shotclock.round_timer.paused = true
	shotclock.round_timer.set_wait_time(shotclock.round_timer.wait_time + 25)			
	shotclock.round_timer.paused = false 
