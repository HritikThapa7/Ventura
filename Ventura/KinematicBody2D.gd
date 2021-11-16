extends KinematicBody2D


onready var timer= get_node("Timer")
var body_rotation 
var initial_body_rotation
var is_rotating=true
var is_timer_started=false

const TILE = 40
var IDLE_DURATION = 1.0

export var move_to = Vector2.RIGHT*192
export var speed = 3.0


onready var platform = $rotatingandmoving
onready var tween = $Tween

var follow = Vector2.ZERO

func _ready():
	_init_Tween()
	set_movement_and_rotation(0,0,0,1,1,1,1)
	initial_body_rotation=body_rotation
	set_physics_process(true)

	
	
func _init_Tween():
	var duration = move_to.length() / float(speed * 40) 
	tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(self, "follow", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + IDLE_DURATION *2)
	tween.start()


func set_movement_and_rotation(direction_x,direction_y,body_rotation_given,scale_x,scale_y,final_scale_in_x,final_scale_in_y):
	body_rotation=body_rotation_given



func _physics_process(delta):
	#platform.position = platform.position.linear_interpolate(follow , 0.075)
	if is_rotating:
		body_rotation=body_rotation  + 5
		set_rotation_degrees(body_rotation)
#		if body_rotation-initial_body_rotation==180:
#			initial_body_rotation=body_rotation
#			is_rotating=false
	if not is_rotating:
		if not is_timer_started:
			timer.start(1)
			is_timer_started=true
	

func _on_Timer_timeout():
		is_rotating=true
		is_timer_started=false