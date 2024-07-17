extends Control

@export var game_stats: GameStats

@onready var score_value = %ScoreValue
@onready var high_score_value = %HighScoreValue
@onready var v_box_container = $VBoxContainer

func _ready():
	var tween = create_tween()
	tween.tween_property(v_box_container, "modulate", Color("ffffffff"), 1.0).from(Color("ffffff00"))
	
	score_value.text = str(game_stats.score)
	high_score_value.text = str(game_stats.high_score)


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://menus/start_menu.tscn")
