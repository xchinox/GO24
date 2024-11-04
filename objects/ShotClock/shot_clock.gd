extends Node3D

var remaining_duration: float = GameVal.round_duration
var timer: Timer = Timer.new()

@onready var clock_mesh: MeshInstance3D = get_node("MeshInstance3D")
@onready var textmesh: TextMesh = clock_mesh.mesh
func _ready() -> void:
	add_child(timer)
	timer.wait_time = remaining_duration
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _physics_process(_delta: float) -> void:	
	textmesh.text = format_float(timer.time_left)


func format_float(time: float) -> String:
	var seconds: int = int(time)
	var milliseconds: int = int((time - seconds) * 100)	
	var formatted_time: String = "%02d:%02d" % [seconds, milliseconds]
	return formatted_time

func _on_timer_timeout() -> void:
	print("TIMEOUT")
