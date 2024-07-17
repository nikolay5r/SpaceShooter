extends Node2D

@onready var move_component = $MoveComponent
@onready var spawner_component = $SpawnerComponent
@onready var animated_body = $Anchor/AnimatedBody
@onready var animated_flames = $Anchor/AnimatedFlames
@onready var left_marker = $SpawnLaserMarkers/LeftMarker
@onready var right_marker = $SpawnLaserMarkers/RightMarker
@onready var fire_rate_timer = $FireRateTimer
@onready var scale_component = $ScaleComponent
@onready var hurtbox_component = $HurtboxComponent
@onready var stats_component = $StatsComponent

var can_shoot = true

func _ready():
	fire_rate_timer.timeout.connect(func(): can_shoot = true)
	

func _process(_delta):
	if Input.is_action_pressed("shoot"):
		fire_lasers()
	
	_animate_ship()


func fire_lasers():
	if can_shoot:
		can_shoot = false
		spawner_component.spawn(left_marker.global_position)
		spawner_component.spawn(right_marker.global_position)
		fire_rate_timer.start()
		scale_component.tween_scale()


func _animate_ship():
	if move_component.velocity.x < 0:
		animated_body.play("left")
		animated_flames.play("left")
	elif move_component.velocity.x > 0:
		animated_body.play("right")
		animated_flames.play("right")
	else:
		animated_body.play("center")
		animated_flames.play("center")
