@tool
extends EditorPlugin

const AUTOLOAD_NAME = "MusicController"

func _enter_tree():
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/timchi_global_music_player/MusicController.tscn")


func _exit_tree():
	remove_autoload_singleton(AUTOLOAD_NAME)
