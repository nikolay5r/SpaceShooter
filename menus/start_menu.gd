extends Control

@onready var v_box_container = $VBoxContainer

func _ready():
	var tween = create_tween()
	tween.tween_property(v_box_container, "modulate", Color("ffffffff"), 1.0).from(Color("ffffff00"))


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://world.tscn")
