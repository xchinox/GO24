class_name CharacterModel
extends Node3D


var glyph: String = "A"



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
	var scene := scene_dict[glyph] as PackedScene
	var face: Node3D = scene.instantiate()

	add_child.call_deferred(face)
	
