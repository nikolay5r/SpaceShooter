extends Node2D

@onready var spawner_component = $SpawnerComponent
@onready var spawn_timer = $SpawnTimer

@export var game_stats: GameStats
@export var enemy_scene: PackedScene
@export var wait_time: int = 3
@export var margin: int = 8
@export var time_offset: float = 1

var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var start_score: int

func _ready():
	spawner_component.scene_to_spawn = enemy_scene
	spawn_timer.wait_time = wait_time
	spawn_timer.timeout.connect(
		func(): 
			spawner_component.spawn(Vector2(randf_range(margin, screen_width - margin), -2 * margin))
			var spawn_rate = time_offset / (0.5 + (0.01 * (game_stats.score - start_score)))
			var time = wait_time * spawn_rate + randf_range(0.0, 0.5)
			print(time)
			spawn_timer.start(time)
			print(spawn_timer.time_left)
	)


func generate():
	spawn_timer.start()
	start_score = game_stats.score


func stop_generate():
	spawn_timer.stop()
