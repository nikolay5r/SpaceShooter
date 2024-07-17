extends Node

var game_stats: = load("res://resources/game_stats/game_stats.tres") as GameStats

const GAME_STATS_SAVE_DIR = "user://saves/"
const GAME_STATS_SAVE_FILE = "game_stats.cfg"
const GAME_STATS_SAVE_PATH = GAME_STATS_SAVE_DIR + GAME_STATS_SAVE_FILE

func _ready():
	DirAccess.make_dir_absolute(GAME_STATS_SAVE_DIR)
	game_stats.high_score = load_stat("game_stats", "high_score")

func save_stat(section: String, key: String, value):
	var config_file = ConfigFile.new()
	config_file.set_value(section, key, value)
	if config_file.save(GAME_STATS_SAVE_PATH) != OK:
		print("Error: Couldn't open file to save.")
		return


func load_stat(section: String, key: String):
	var config_file = ConfigFile.new()
	if config_file.load(GAME_STATS_SAVE_PATH) != OK:
		print("Error: Couldn't open file to save.")
		return
	return config_file.get_value(section, key)
