class_name Brigand
extends PlayerUnit

@onready var model: Node3D = get_node("Model")
@onready var slash_effect_scene: PackedScene = load("res://scenes/sword_slash_effect.tscn")

func _ready() -> void:
	role = Role.MELEE
	health = max_health
	hp_bar = hp_bar_scene.instantiate()	
	add_child(hp_bar)	
	update_health_bar()

func execute_action(_party: Party, enemy_party: EnemyParty) -> void:
	var target: Enemy = null
	var damage_amount: int = 40
	for enemy in enemy_party.members:
		if int(enemy.health/enemy.max_health) * 100 < 20:
			target = enemy
		elif int(enemy.health/enemy.max_health) * 100 > 80:			
			target = enemy

		else:
			target = enemy_party.members.pick_random()
	shadow_step(target)	
	NoiseManager.play_sfx("Slash")
	if target.is_high_health() || target.is_low_health():
		damage_amount += int(damage_amount * .5)
	target.take_hit(damage_amount)


func shadow_step(enemy: Enemy) -> void:
	var origin: Vector3 = global_position	
	global_position = enemy.global_position + Vector3(-.5, 0, 0)
	rotation_degrees.y = -180
	var slash: Node3D = slash_effect_scene.instantiate()				
	get_parent().add_child(slash)
	slash.global_position = global_position
	slash.scale *= 2
	slash.global_position.y += .5
	slash.global_position.z += .5
	slash.global_position.x -= 1
	
	
	await get_tree().create_timer(1).timeout
	
	var tween: Tween = create_tween()
	#tween.tween_property(self, "global_position", enemy.global_position, 0.15)
	tween.tween_property(self, "global_position", origin, .250) 
	
	
	rotation_degrees.y = 0
