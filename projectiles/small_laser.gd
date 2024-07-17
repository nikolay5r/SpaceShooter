extends Node2D

@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D
@onready var flash_component = $FlashComponent
@onready var scale_component = $ScaleComponent
@onready var hitbox_component = $HitboxComponent

func _ready():
	visible_on_screen_notifier_2d.connect("screen_exited", queue_free)
	hitbox_component.hit_hurtbox.connect(func(_hurtbox): queue_free())
	
	flash_component.flash()
	scale_component.tween_scale()
