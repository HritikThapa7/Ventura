extends KinematicBody2D

onready var timer= get_node("Timer")
var body_rotation 
var initial_body_rotation
var is_rotating=true
var is_timer_started=false


func set_movement_and_rotation(direction_x,direction_y,body_rotation_given,scale_x,scale_y,final_scale_in_x,final_scale_in_y):
	body_rotation=body_rotation_given

func _ready():
	set_movement_and_rotation(0,0,0,1,1,1,1)
	initial_body_rotation=body_rotation
	set_physics_process(true)

func _physics_process(delta):
	if is_rotating:
		body_rotation=body_rotation  + 1
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