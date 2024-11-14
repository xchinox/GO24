class_name Brigand
extends PlayerUnit

@onready var model: Node3D = get_node("Model")

func _ready() -> void:
	role = Role.MELEE
	health = max_health
	hp_bar = hp_bar_scene.instantiate()	
	add_child(hp_bar)	
	update_health_bar()

func execute_action(party: Party, enemy_party: EnemyParty) -> void:
	var target: Enemy = null
	for enemy in enemy_party.members:
		if (enemy.health/enemy.max_health) * 100 < 20:
			target = enemy
			print("LOW HEALTH ENEMY")
		
		elif (enemy.health/enemy.max_health) * 100 > 80:
			print("HIGH HEALTH ENEMY")
			target = enemy

		else:
			target = enemy_party.members.pick_random()
	shadow_step(target)	
	target.take_hit(80)


func shadow_step(enemy: Enemy) -> void:
	var origin: Vector3 = global_position	
	global_position = enemy.global_position + Vector3(-.5, 0, 0)
	rotation_degrees.y = -180
	await get_tree().create_timer(1).timeout
	
	var tween: Tween = create_tween()
	#tween.tween_property(self, "global_position", enemy.global_position, 0.15)
	tween.tween_property(self, "global_position", origin, .250) 
	rotation_degrees.y = 0
