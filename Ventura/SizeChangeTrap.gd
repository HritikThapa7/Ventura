extends KinematicBody2D


onready var tween=get_node("Tween")
onready var timer=get_node("Timer")

export var time=0.6

var along_x
var along_y
var final_scale_x
var final_scale_y
var is_pushed=false

func set_movement_and_rotation(direction_x,direction_y,body_rotation_given,scale_x,scale_y,final_scale_in_x,final_scale_in_y):
	along_x=scale_x
	along_y=scale_y
	final_scale_x=final_scale_in_x
	final_scale_y=final_scale_in_y

func _ready() -> void:
	set_movement_and_rotation(0,0,0,1,1,6,1)
	set_physics_process(true)
	
func _physics_process(delta: float) -> void:
	if not is_pushed:
		if final_scale_x != 1 and final_scale_y==1:
			push_along_x()
		if final_scale_x==1 and final_scale_y!=1:
			push_along_y()
	if is_pushed:
		if final_scale_x != 1 and final_scale_y==1:
			pull_along_x()
		if final_scale_x==1 and final_scale_y!=1:
			pull_along_y()

func _on_Timer_timeout() -> void:
	is_pushed=false
	set_physics_process(true)

func push_along_x():
	along_x=along_x+0.5
	set_scale(Vector2(along_x,along_y))
	if get_scale()==Vector2(final_scale_x,final_scale_y):
		is_pushed=true

func pull_along_x():
	along_x=along_x-0.125
	set_scale(Vector2(along_x,along_y))
	if(get_scale()==Vector2(1,1)):
		timer.start(time)
		set_physics_process(false)
	
func push_along_y():
	along_y=along_y+0.5
	set_scale(Vector2(along_x,along_y))
	if get_scale()==Vector2(final_scale_x,final_scale_y):
		is_pushed=true

func pull_along_y():
	along_y=along_y-0.125
	set_scale(Vector2(along_x,along_y))
	if(get_scale()==Vector2(1,1)):
		timer.start(time)
		set_physics_process(false)

