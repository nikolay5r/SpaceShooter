class_name Enemy
extends Node2D

@onready var stats_component = $StatsComponent
@onready var move_component = $MoveComponent
@onready var shake_component = $ShakeComponent
@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D
@onready var hurtbox_component = $HurtboxComponent
@onready var hitbox_component = $HitboxComponent
@onready var flash_component = $FlashComponent
@onready var destroyed_component = $DestroyedComponent
@onready var score_component = $ScoreComponent
@onready var variable_pitch_audio_stream_player = $VariablePitchAudioStreamPlayer

func _ready():
	stats_component.no_health.connect(score_component.adjust_score)
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(func(_hurtbox): 
		destroyed_component.destroy()
	)
	hurtbox_component.hurt.connect(func(_hitbox):
		shake_component.tween_shake()
		flash_component.flash()
		variable_pitch_audio_stream_player.play_with_variance()
	)
