extends Node2D

@export var game_stats: GameStats

@onready var pink_enemy_generator = $PinkEnemyGenerator
@onready var yellow_enemy_generator = $YellowEnemyGenerator
@onready var green_enemy_generator = $GreenEnemyGenerator
@onready var ship = $Ship
@onready var score_label = $ScoreLabel

var can_spawn_yellow_enemy = false
var can_spawn_pink_enemy = false

const PINK_ENEMY_MIN_SCORE_TO_SPAWN = 150
const YELLOW_ENEMY_MIN_SCORE_TO_SPAWN = 50

func _ready():
	randomize()
	game_stats.score = 0
	game_stats.score_changed.connect(
		func(new_score: int):
			score_label.text = "Score: " + str(new_score)
	)
	
	green_enemy_generator.generate()
	ship.tree_exiting.connect(_handle_game_over)


func _process(_delta):
	if not can_spawn_yellow_enemy and game_stats.score >= YELLOW_ENEMY_MIN_SCORE_TO_SPAWN:
		yellow_enemy_generator.generate()
		can_spawn_yellow_enemy = true
	
	if not can_spawn_pink_enemy and game_stats.score >= PINK_ENEMY_MIN_SCORE_TO_SPAWN:
		pink_enemy_generator.generate()
		can_spawn_pink_enemy = true

func _handle_game_over():
	green_enemy_generator.stop_generate()
	yellow_enemy_generator.stop_generate()
	pink_enemy_generator.stop_generate()
	
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.destroyed_component.destroy()
	
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://menus/game_over_menu.tscn")
