extends Enemy

@onready var states = $States
@onready var move_down_timed_state = %MoveDownTimedState
@onready var move_side_timed_state = %MoveSideTimedState
@onready var fire_projectile_timed_state = %FireProjectileTimedState
@onready var move_side_component = %MoveSideComponent
@onready var projectile_spawner_component = %ProjectileSpawnerComponent
@onready var projectile_spawn_marker = $ProjectileSpawnMarker
@onready var scale_component = $ScaleComponent

func _ready():
	super()
	
	for state in states.get_children():
		state.disable()
	
	move_down_timed_state.state_finished.connect(_move_side)
	move_side_timed_state.state_finished.connect(_fire_projectile)
	fire_projectile_timed_state.state_finished.connect(move_down_timed_state.enable)
	move_down_timed_state.enable()


func _move_side():
	move_side_component.velocity.x = [-25, 25].pick_random()
	move_side_timed_state.enable()

func _fire_projectile():
	fire_projectile_timed_state.enable()
	
	await get_tree().create_timer(fire_projectile_timed_state.duration / 2).timeout
	projectile_spawner_component.spawn(projectile_spawn_marker.global_position)
	scale_component.tween_scale()
