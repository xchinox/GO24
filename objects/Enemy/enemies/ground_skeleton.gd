class_name GroundSkeleton
extends Enemy


@onready var anim_player: AnimationPlayer = get_node("ground_skeleton/AnimationPlayer")
@onready var bone_toss_anim: AnimationPlayer  = get_node("AnimationPlayer")

@onready var projectile: Node3D = get_node("bone_projectile")
var target: PlayerUnit
@onready var projectile_origin: Vector3 = projectile.position

func _ready() -> void:
	health = max_health
	bone_toss_anim.animation_finished.connect(throw)
	hp_bar = hp_bar_scene.instantiate()	
	add_child(hp_bar)	
	hp_bar.scale = Vector3(-5,5,5)#
	hp_bar.position.x = 30		  # scale, flip, and adjust position since model was built facing right
	
	update_health_bar()

func execute_action(party: Party) -> void:		
	target = party.members.pick_random()	
	anim_player.play("Cube_242Action")
	bone_toss_anim.play("bone_toss")
	
func throw(_name: String) -> void:
	var tween: Tween = create_tween()	
	var tarpos: Vector3 = target.global_position
	tween.tween_property(projectile, "global_position", tarpos, 2.0,).set_trans(Tween.TransitionType.TRANS_SINE).set_ease(Tween.EaseType.EASE_IN_OUT)
	tween.parallel().tween_property(projectile, "rotation_degrees:x", 1080, 2.0) 
	tween.finished.connect(Callable(reset_projectile).bind(target))


func reset_projectile(target: PlayerUnit) -> void:
	projectile.position = projectile_origin
	projectile.visible = false
	target.take_hit(50, self)
	signal_action_complete()
