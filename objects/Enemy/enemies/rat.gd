class_name Rat
extends Enemy

@onready var animplayer: AnimationPlayer = get_node("rat/AnimationPlayer")
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	health = max_health
	hp_bar = hp_bar_scene.instantiate()	
	add_child(hp_bar)	
	hp_bar.scale = Vector3(-6,5,5)#
	hp_bar.position.x = 30		  # scale, flip, and adjust position since model was built facing right	
	update_health_bar()
	

func execute_action(party: Party) -> void:
	animplayer.play("Cube_312Action")		
	shadow_step(party.members.pick_random() as PlayerUnit)
	
func shadow_step(enemy: PlayerUnit) -> void:
	var origin: Vector3 = global_position	
	global_position = enemy.global_position + Vector3(-.5, 0, 0)
	rotation_degrees.y = -180
	NoiseManager.play_sfx("Squeak")
	await get_tree().create_timer(1).timeout
	
	
	var tween: Tween = create_tween()
	#tween.tween_property(self, "global_position", enemy.global_position, 0.15)
	tween.tween_property(self, "global_position", origin, .250) 
	tween.finished.connect(signal_action_complete)
	rotation_degrees.y = 0
	
	enemy.take_hit(15, self)
