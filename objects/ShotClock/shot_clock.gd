class_name ShotClock
extends Node3D

var remaining_duration: float = GameVal.round_duration
var round_timer: Timer = Timer.new()
var crit_window: Timer = Timer.new()

signal crit_window_timeout
signal round_timout

@onready var clock_mesh: MeshInstance3D = get_node("MeshInstance3D")
@onready var textmesh: TextMesh = clock_mesh.mesh
func _ready() -> void:
	add_child(round_timer)
	round_timer.one_shot = true
	round_timer.wait_time = remaining_duration	
	round_timer.timeout.connect(_on_round_timer_timeout)


	add_child(crit_window)
	crit_window.wait_time = GameVal.crit_window_duration
	crit_window.timeout.connect(_on_crit_window_timeout)
	crit_window.one_shot = true

	round_timer.start()

	crit_window.start()
func _physics_process(_delta: float) -> void:	
	textmesh.text = format_float(round_timer.time_left)


func format_float(time: float) -> String:
	var seconds: int = int(time)
	var milliseconds: int = int((time - seconds) * 100)	
	var formatted_time: String = "%02d:%02d" % [seconds, milliseconds]
	return formatted_time

func _on_round_timer_timeout() -> void:
	round_timout.emit()

func _on_crit_window_timeout() -> void:
	crit_window_timeout.emit()

func reset() -> void:
	round_timer.wait_time = remaining_duration	
	crit_window.wait_time = GameVal.crit_window_duration
	round_timer.start()
	crit_window.start()
