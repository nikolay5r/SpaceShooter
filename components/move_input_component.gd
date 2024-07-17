class_name MoveInputComponent
extends Node

@export var move_component: MoveComponent
@export var move_stats: MoveStats

func _input(_event):
	var direction = Input.get_vector("left", "right", "up", "down")
	move_component.velocity = direction * move_stats.speed
