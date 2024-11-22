extends Node

const CHANNELS: int = 16

var sfx_paths: Dictionary = { 
	"SelectionSound" : load("res://assets/sound/sfx/drop.ogg"),
	"Error" : load("res://assets/sound/sfx/error.ogg"),
	"Slash" : load("res://assets/sound/sfx/metal_sliding.ogg"),
	"Explosion" : load("res://assets/sound/sfx/cinematic_explosion.ogg"),
	"Firework" : load("res://assets/sound/sfx/firework01.ogg"),
	"HappyChord" : load("res://assets/sound/sfx/happy_chord.ogg"),
	"VoxChord" : load("res://assets/sound/sfx/vox_chord.ogg"),
	"ImpactMining" : load("res://assets/sound/sfx/impactMining_002.ogg"),
	"Squeak" : load("res://assets/sound/sfx/squeak_and_tear.ogg"),
	
}

var sfx_streams: Dictionary

var available_players: Array[AudioStreamPlayer]

func _ready() -> void:
	#Intialize an array of empty audiostreamplayers
	#when we use a player it is removed from the array 
	#when a finished signal is recieved it is added back into the pool
	
	for i in range(0, CHANNELS-1):
		var pl: AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(pl)
		available_players.append(pl)
		pl.finished.connect(Callable(_on_playback_finished).bind(pl))
	

func play_sfx(sound: String) -> void:
	var aplayer: AudioStreamPlayer = available_players.pick_random()
	available_players.erase(aplayer)
	aplayer.stream = sfx_paths[sound]
	aplayer.play()

func _on_playback_finished(player: AudioStreamPlayer) -> void:
	available_players.append(player)
