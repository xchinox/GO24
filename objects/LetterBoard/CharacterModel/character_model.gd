class_name CharacterModel
extends Node3D


var glyph: String = "A"
var face: Node3D
var mesh: MeshInstance3D

var material: Material = Material.new()

signal character_clicked
signal mouse_entered


@onready var area_scene: PackedScene = load("res://objects/LetterBoard/CharacterModel/character_area.tscn")
var area: Area3D

@onready var a: PackedScene = load("res://assets/models/characters/a.blend")
@onready var b: PackedScene = load("res://assets/models/characters/b.blend")
@onready var c: PackedScene = load("res://assets/models/characters/c.blend")
@onready var d: PackedScene = load("res://assets/models/characters/d.blend")
@onready var e: PackedScene = load("res://assets/models/characters/e.blend")
@onready var f: PackedScene = load("res://assets/models/characters/f.blend")
@onready var g: PackedScene = load("res://assets/models/characters/g.blend")
@onready var h: PackedScene = load("res://assets/models/characters/h.blend")
@onready var i: PackedScene = load("res://assets/models/characters/i.blend")
@onready var j: PackedScene = load("res://assets/models/characters/j.blend")
@onready var k: PackedScene = load("res://assets/models/characters/k.blend")
@onready var l: PackedScene = load("res://assets/models/characters/l.blend")
@onready var m: PackedScene = load("res://assets/models/characters/m.blend")
@onready var n: PackedScene = load("res://assets/models/characters/n.blend")
@onready var o: PackedScene = load("res://assets/models/characters/o.blend")
@onready var p: PackedScene = load("res://assets/models/characters/p.blend")
@onready var q: PackedScene = load("res://assets/models/characters/q.blend")
@onready var r: PackedScene = load("res://assets/models/characters/r.blend")
@onready var s: PackedScene = load("res://assets/models/characters/s.blend")
@onready var t: PackedScene = load("res://assets/models/characters/t.blend")
@onready var u: PackedScene = load("res://assets/models/characters/u.blend")
@onready var v: PackedScene = load("res://assets/models/characters/v.blend")
@onready var w: PackedScene = load("res://assets/models/characters/w.blend")
@onready var x: PackedScene = load("res://assets/models/characters/x.blend")
@onready var y: PackedScene = load("res://assets/models/characters/y.blend")
@onready var z: PackedScene = load("res://assets/models/characters/z.blend")

@onready var scene_dict: Dictionary = {
	"A": a,
	"B": b,
	"C": c,
	"D": d,
	"E": e,
	"F": f,
	"G": g,
	"H": h,
	"I": i,
	"J": j,
	"K": k,
	"L": l,
	"M": m,
	"N": n,
	"O": o,
	"P": p,
	"Q": q,
	"R": r,
	"S": s,
	"T": t,
	"U": u,
	"V": v,
	"W": w,
	"X": x,
	"Y": y,
	"Z": z,
	}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area = area_scene.instantiate()
	add_child(area)
	
	area.input_event.connect(_on_input_event)
	area.mouse_entered.connect(_on_mouse_entered)

	var scene := scene_dict[glyph] as PackedScene
	face = scene.instantiate()		
	add_child.call_deferred(face)
	mesh = face.get_node("Text")
	mesh.set_surface_override_material(0, get_material(false))	


func _on_input_event(_camera: Camera3D, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:		
		character_clicked.emit(self, event)
		

func _on_mouse_entered() -> void:
	mouse_entered.emit(self)


func toggle_emit(switch: bool) -> void:
	var smat: StandardMaterial3D = mesh.get_active_material(0)
	smat.emission_enabled = switch
	mesh.set_surface_override_material(0, smat)
	

func get_material(emit: bool) -> StandardMaterial3D:
	var smat := StandardMaterial3D.new()
	
	smat.emission_enabled = emit
	smat.emission = Color.BURLYWOOD
	return smat
