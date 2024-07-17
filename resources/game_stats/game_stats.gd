class_name GameStats
extends Resource

signal score_changed(new_score: int)

@export var score: int = 0:
	set(value):
		score = value
		if high_score < score:
			high_score = score
			SaveSystem.save_stat("game_stats", "high_score", high_score)
		score_changed.emit(score)

@export var high_score: int = 0
