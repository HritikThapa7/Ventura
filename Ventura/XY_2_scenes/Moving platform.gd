extends Node2D

const TILE = 40
var IDLE_DURATION = 1.0

export var move_to = Vector2.RIGHT*192
export var speed = 3.0


onready var platform = $moving_platform
onready var tween = $Tween

var follow = Vector2.ZERO



func _ready():
	_init_Tween()
	
func _init_Tween():
	var duration = move_to.length() / float(speed * 40) 
	tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(self, "follow", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + IDLE_DURATION *2)
	tween.start()
	
func _physics_process(delta):
	platform.position = platform.position.linear_interpolate(follow , 0.075)
	
