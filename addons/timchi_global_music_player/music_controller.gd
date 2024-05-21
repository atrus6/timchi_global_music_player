extends Node

var players = []

var current_bus = 0

var current_pos = 0.0

var FADE_LENGTH = 2.0

var TRACKS_LOCATION = "res://music/"

var tracks = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	players.append($Player1)
	players.append($Player2)
	players.append($Player3)
	

func load_tracks():
	var dir = DirAccess.open(TRACKS_LOCATION)
	
	if !dir:
		print("Unable to open " + TRACKS_LOCATION)
		
	dir.list_dir_begin()
	var filename = dir.get_next()
	
	while filename != "":
		if !dir.current_is_dir():
			if filename.ends_with(".ogg") || filename.ends_with(".mp3") || filename.ends_with(".wav"):
				tracks[filename] = TRACKS_LOCATION + filename
		filename = dir.get_next()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func get_current_player() -> AudioStreamPlayer:
	return players[current_bus]
	
func next_player():
	current_bus += 1
	current_bus %= 3

func fade_out():
	var tween_vol = get_tree().create_tween()
	var current = get_current_player()
	
	tween_vol.tween_property(current, "volume_db", -50, FADE_LENGTH)
	tween_vol.tween_callback(current.stop)
	
func stop():
	current_pos = get_current_player().get_playback_position()
	get_current_player().stop()

func play():
	get_current_player().play(current_pos)
	
func switch_track(track:String):
	fade_out()
	next_player()
	var tween_vol = get_tree().create_tween()
	var current = get_current_player()
	current.stream = load(tracks[track])
	current.play()
	current.volume_db = -50
	tween_vol.tween_property(current, "volume_db", 0, FADE_LENGTH)
	


func _on_player_1_finished():
	players[0].play()


func _on_player_2_finished():
	players[1].play()


func _on_player_3_finished():
	players[2].play()
